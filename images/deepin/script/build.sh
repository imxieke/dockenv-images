#!/usr/bin/env bash

function init_env()
{
	echo '=>Modify Default Ubutnu Software Mirrors'
	sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list
	sed -i 's/deb\ http:\/\/security/#deb\ http:\/\/security/g' /etc/apt/sources.list

	# Install nss-wrapper to be able to execute image as non-root user

	echo "=>Generate locales en_US.UTF-8"
	locale-gen en_US.UTF-8

	# echo "=>Add 'source generate_container_user' to .bashrc"
	# have to be added to hold all env vars correctly
	# echo 'source $STARTUPDIR/generate_container_user' >> $HOME/.bashrc

	echo '=>Set Locale'
	echo 'LANG='en_US.UTF-8'' >> $HOME/.bashrc
	echo 'LANGUAGE='en_US:en'' >> $HOME/.bashrc
	echo 'LC_ALL='en_US.UTF-8'' >> $HOME/.bashrc

	echo '=> Config Chromium: write correct window size to chrome properties'
	VNC_RES_W=${VNC_RESOLUTION%x*}
	VNC_RES_H=${VNC_RESOLUTION#*x}

	echo -e "\n=>Update chromium-browser.init"
	echo -e "\n=>Set window size $VNC_RES_W x $VNC_RES_H as chrome window size!\n"
	echo "CHROMIUM_FLAGS='--no-sandbox --disable-gpu --user-data-dir --window-size=$VNC_RES_W,$VNC_RES_H --window-position=0,0'" > $HOME/.chromium-browser.init

	# Config VNC
	echo '=>Start Config VNC'
	echo "==>Install TigerVNC server"
	wget -qO- https://qcloud.coding.net/u/imxieke/p/Collect/git/raw/master/src/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /
	echo "==>Install noVNC - HTML5 based VNC viewer"
	mkdir -p $NO_VNC_HOME/utils/websockify
	wget -qO- https://qcloud.coding.net/u/imxieke/p/Collect/git/raw/master/src/no-vnc_v1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME
	# use older version of websockify to prevent hanging connections on offline containers, see https://github.com/ConSol/docker-headless-vnc-container/issues/50
	wget -qO- https://qcloud.coding.net/u/imxieke/p/Collect/git/raw/master/src/websockify_v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
	chmod +x -v $NO_VNC_HOME/utils/*.sh
	## create index.html to forward automatically to `vnc_lite.html`
	ln -s $NO_VNC_HOME/vnc.html $NO_VNC_HOME/index.html
}

# Start Build
echo '=>Start Build Ubuntu VNC Server on Docker '
init_env

# Set current user in nss_wrapper
NSS_WRAPPER_PASSWD=/etc/passwd
NSS_WRAPPER_GROUP=/etc/group

# cat /etc/passwd > $NSS_WRAPPER_PASSWD
# echo "${USER}:x:${USER_ID}:${GROUP_ID}:Default Application User:${HOME}:/bin/bash" >> $NSS_WRAPPER_PASSWD

echo 'export NSS_WRAPPER_PASSWD' >> $HOME/.bashrc
echo 'export NSS_WRAPPER_GROUP' >> $HOME/.bashrc

if [ -r /usr/lib/libnss_wrapper.so ]; then
    LD_PRELOAD=/usr/lib/libnss_wrapper.so
elif [ -r /usr/lib64/libnss_wrapper.so ]; then
    LD_PRELOAD=/usr/lib64/libnss_wrapper.so
else
    echo "no libnss_wrapper.so installed!"
	exit 1
fi

echo 'export LD_PRELOAD' >> $HOME/.bashrc
useradd -d /home/${USER} -m -s /bin/zsh ${USER}
echo "${USER}:${PASSWD}" | chpasswd
echo "root:${PASSWD}" | chpasswd
echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers

echo 'Config oh my zsh'
echo "Cloning oh my zsh to $HOME"
#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
git clone --depth=1 https://git.dev.tencent.com/imxieke/ohmyzsh.git ${HOME}/.oh-my-zsh
cp ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc

echo 'Set Catelog Permission'
find "${HOME}"/ -name '*.desktop' -exec chmod $verbose a+x {} +
chmod -R a+rw ${HOME}
chmod -R a+rw ${STARTUPDIR}
chmod -R a+x ${STARTUPDIR}/*.sh
chmod -R 755 $HOME
chown -R ${USER}:${USER} ${HOME}
chown -R ${USER}:${USER} ${STARTUPDIR}
chown -R ${USER}:${USER} ${HOME}/.*
chown ${USER}:${USER} ${HOME}/.zshrc