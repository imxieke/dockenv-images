#!/usr/bin/env bash

chmod +x /bin/startup.sh

echo '=>Start Config VNC'
echo "==>Install TigerVNC server"
wget -qO- --no-check-certificate https://dev.tencent.com/u/imxieke/p/attachment/git/raw/master/src/tigervnc-1.8.0.x86_64.tar.gz | tar xz --strip 1 -C /
echo "==>Install noVNC - HTML5 based VNC viewer"
mkdir -p $NO_VNC_HOME/utils/websockify
wget -qO- --no-check-certificate https://dev.tencent.com/u/imxieke/p/attachment/git/raw/master/src/no-vnc_v1.0.0.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME
# use older version of websockify to prevent hanging connections on offline containers, see https://github.com/ConSol/docker-headless-vnc-container/issues/50
wget -qO- --no-check-certificate https://dev.tencent.com/u/imxieke/p/attachment/git/raw/master/src/websockify_v0.6.1.tar.gz | tar xz --strip 1 -C $NO_VNC_HOME/utils/websockify
chmod +x -v $NO_VNC_HOME/utils/*.sh
## create index.html to forward automatically to `vnc_lite.html`
ln -s $NO_VNC_HOME/vnc.html $NO_VNC_HOME/index.html

# git clone --depth=1 https://git.dev.tencent.com/imxieke/ohmyzsh.git /tmp/oh-my-zsh

echo "Set User infomation"
if [[ -n ${USER} ]]; then
    if [[ -z ${PASSWD} ]]; then
        PASSWD='ubuntu'
    fi
    echo "Create User: ${USER}"
    useradd -d /home/${USER} -m -s /bin/zsh ${USER}
    echo "${USER}:${PASSWD}" | chpasswd
    echo "root:${PASSWD}" | chpasswd
    echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
else
    if [[ -z ${PASSWD} ]]; then
        PASSWD='ubuntu'
    fi
    echo "Create User: ubuntu"
    useradd -d /home/ubuntu -m -s /bin/zsh ubuntu
    echo "ubuntu:${PASSWD}" | chpasswd
    echo "root:${PASSWD}" | chpasswd
    echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
fi

echo '=>Config oh my zsh'
echo "=>Cloning oh my zsh to $HOME"
# cp -R /tmp/oh-my-zsh ${HOME}/.oh-my-zsh
git clone --depth=1 https://git.dev.tencent.com/imxieke/ohmyzsh.git ${HOME}/.oh-my-zsh
cp ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc

sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="strug"/g' ${HOME}/.zshrc

echo "[program:vncserver]
command=vncserver -geometry ${VNC_RESOLUTION} ${DISPLAY}
user=${USER}

[program:noVNC]
command=$NO_VNC_HOME/utils/launch.sh --vnc localhost:${VNC_PORT} --listen ${NO_VNC_PORT}
user=${USER}
stdout_logfile=/var/log/novnc.log
redirect_stderr=true" > /etc/supervisor/conf.d/supervisor.conf

echo "/usr/lib/gnome-session/gnome-session-binary --session=ubuntu  > /tmp/gnome-session-binary.log &
/usr/lib/x86_64-linux-gnu/unity/unity-panel-service > /tmp/unity-panel-service.log &
/usr/lib/unity-settings-daemon/unity-settings-daemon > /tmp/unity-settings-daemon.log &

for indicator in /usr/lib/x86_64-linux-gnu/indicator-*; do
  basename=\`basename \${indicator}\`
  dirname=\`dirname \${indicator}\`
  service=\${dirname}/\${basename}/\${basename}-service
  \${service} &
done

unity > /tmp/unity.log & " > ${HOME}/.xsession

echo '=>Set Locale'
echo "=>Generate locales"

touch /var/lib/locales/supported.d/local
touch /var/lib/locales/supported.d/en

echo "en_US.UTF-8 UTF-8" > /var/lib/locales/supported.d/en

echo "en_US.UTF-8 UTF-8" >> /var/lib/locales/supported.d/local
echo "zh_CN.UTF-8 UTF-8" >> /var/lib/locales/supported.d/local

echo "LANGUAGE=\"zh_CN:zh:en_US:en\"" >> $HOME/.bashrc
echo "LANG=\"en_US.UTF-8\"" >> $HOME/.bashrc

echo "
LANG=\"en_US.UTF-8\"
LANGUAGE=\"zh_CN:zh:en_US:en\"" >> /etc/environment

# echo "
# LANG=\"en_US.UTF-8\"
# LANGUAGE=\"zh_CN:zh:en_US:en\"
# LC_CTYPE=\"en_US.UTF-8\"
# LC_NUMERIC=\"en_US.UTF-8\"
# LC_TIME=\"en_US.UTF-8\"
# LC_COLLATE=\"en_US.UTF-8\"
# LC_MONETARY=\"en_US.UTF-8\"
# LC_MESSAGES=\"en_US.UTF-8\"
# LC_PAPER=\"en_US.UTF-8\"
# LC_NAME=\"en_US.UTF-8\"
# LC_ADDRESS=\"en_US.UTF-8\"
# LC_TELEPHONE=\"en_US.UTF-8\"
# LC_MEASUREMENT=\"en_US.UTF-8\"
# LC_IDENTIFICATION=\"en_US.UTF-8\"
# LC_ALL= " >> ${HOME}/.zshrc

sed -i 's/# zh_CN.UTF-8/zh_CN.UTF-8/g' /etc/locale.gen

mkdir -p /etc/default/

if [[ ! -f '/etc/default/locale' ]]; then
    touch /etc/default/locale
echo "
LANG=\"en_US.UTF-8\"
LANGUAGE=\"zh_CN:zh:en_US:en\"" > /etc/default/locale
else
echo "
LANG=\"en_US.UTF-8\"
LANGUAGE=\"zh_CN:zh:en_US:en\"" > /etc/default/locale
fi

locale-gen

chmod -R a+rw ${HOME}
chmod -R 755 $HOME
chown -R ${USER}:${USER} ${HOME}
chown -R ${USER}:${USER} ${HOME}/.*
chown ${USER}:${USER} ${HOME}/.zshrc
