#!/usr/bon/env bash
export PATH="/bin:/usr/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:~/bin:~/.bin"

USER="boxs"
PASSWD="boxs"
HOME_DIR=/home/$USER

[ "$(id -u)" != '0' ] && echo 'use root user please' && exit

sapt(){ apt install --no-install-recommends -y $@;}
runs(){ sudo -u "${USER}" $@;}

_do_install()
{
	# fix depends
	[[ -z "$(ls -lha /var/lib/apt/lists/ | grep 'dists')" ]] && apt update -y --fix-missing

	# System base functions
	sapt tzdata lsb-release apt-transport-https apt-utils locales ca-certificates supervisor systemctl

	# Tools
	if [[ -z "$(command -v nvim)" ]]; then
		sapt sudo zsh neovim jq htop git bat net-tools whois neofetch screen screenfetch tree psutils \
		iproute2 telnet curl wget axel openssh-client openssh-server less iftop ncdu openssl expect
	fi

	# Compress Package
	sapt unar bzip2 unzip unrar

	# php7.4
	sapt php7.4-bcmath php7.4-bz2 php7.4-cli php7.4-common php7.4-curl php7.4-dba php7.4-enchant php7.4-gd php7.4-gmp php7.4-imap \
	php7.4-intl php7.4-json php7.4-ldap php7.4-mbstring php7.4-mysql php7.4-odbc php7.4-pgsql php7.4-pspell php7.4-readline \
	php7.4-snmp php7.4-soap php7.4-sqlite3 php7.4-tidy php7.4-xml php7.4-xmlrpc php7.4-xsl php7.4-zip


	# Python
	if [[ -z "$(command -v pip)" ]]; then
		sapt python3-pip python3 python2
	fi
}

_do_install_dev()
{
	sapt gcc make cmake autoconf automake
}

_do_install_dotnet()
{
	# install dotnet
	if [[ -z "$(command -v dotnet)"  ]]; then
		wget https://packages.microsoft.com/config/ubuntu/$(lsb_release -sr)/packages-microsoft-prod.deb -o /tmp/dotnet.deb
		dpkg -i /tmp/dotnet.deb && rm -fr /tmp/dotnet.deb
		apt update && sapt dotnet-sdk-5.0
	fi
}

_config_vnc()
{
	# python-numpy websockify require
	# sapt libnss-wrapper gettext python-numpy
	# pip install numpy
	# sapt chromium-browser chromium-browser-l10n chromium-codecs-ffmpeg ttf-wqy-zenhei
	# spat xfce4 xfce4-terminal xterm
	# apt purge -y pm-utils xscreensaver*

	if [[ ! -d '/opt/noVNC' ]]; then
		git clone --depth 1 https://github.com/novnc/noVNC.git /opt/noVNC
	fi

	if [[ ! -d '/opt/websockify' ]]; then
		git clone --depth 1 https://github.com/novnc/websockify.git /opt/websockify
	fi

	runs mkdir -p $HOME_DIR/.vnc
	echo '$PASSWD' | runs vncpasswd -f > $HOME_DIR/.vnc/passwd
	chmod 600 $HOME_DIR/.vnc/passwd
	touch $HOME_DIR/.Xresources

}

# Config Server Env
_do_install_srv()
{
	wget -qO- https://get.docker.com/ | sh
	sudo usermod -aG docker $USER
}

_install_desktop_unity()
{
	sapt ttf-dejavu ttf-wqy-zenhei ttf-wqy-microhei
	sapt xterm
	sapt ubuntu-desktop unity-lens-applications gnome-panel metacity libtasn1-3-bin libglu1-mesa mate-terminal \
	fonts-liberation language-pack-zh-hans fonts-droid-fallback fonts-arphic-ukai \
	fonts-arphic-uming xfonts-wqy libxss1 xdg-utils libtasn1-3-bin libglu1-mesa
	sapt xorg xfce4 x11vnc  xorg-twm xorg-xclock ratpoison
	sapt xorg-server xorg-apps i3-wm zsh vim git wget net-tools bzip2 python python-pip python-numpy supervisor \
		xterm gettext
	pip install websocket websocketproxy

	echo '#!/bin/sh' > ${HOME}/.xinitrc
	echo 'exec i3' >> ${HOME}/.xinitrc
}

_do_install_gui_pkg()
{
	ls .
	# sublime text gedit
	# https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
}

# Config System Env
_config_env()
{
	# Config Default Timezone
	rm -fr /etc/localtime
	rm -fr /etc/timezone
	ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
	echo "Asia/Shanghai" > /etc/timezone

	# Config User
	if [[ -z "$(grep ${USER} /etc/sudoers)" ]]; then
		echo 'a'
		if [[ -z "$(grep ${USER} /etc/sudoers)" ]]; then
			useradd -d /home/${USER} -m -s /bin/zsh ${USER}
			echo "${USER}:${PASSWD}" | chpasswd
			echo "root:${PASSWD}" | chpasswd
			echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
		fi
	fi
}

_config_ohmyzsh()
{
	# Oh my zsh
	if [[ -n "$(command -v zsh)" ]]; then
		if [[ ! -d "${HOME_DIR}/.oh-my-zsh" ]]; then
			echo '		Config oh my zsh'
			echo "Cloning oh my zsh to ${HOME_DIR}"
			#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
			runs git clone --depth=1 https://gitee.com/mirr/oh-my-zsh.git ${HOME_DIR}/.oh-my-zsh
			runs cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc
			runs sed -i 's/robbyrussell/strug/g' ${HOME_DIR}/.zshrc
			# cp /tmp/.zshrc ${HOME_DIR}/.zshrc
			# chmod 777 ${HOME_DIR}/.zshrc
			# runs chown ${USER}:${USER} ${HOME_DIR}/.zshrc
		fi
	fi
}

_config_pkg()
{

	# PHP
	if [[ -n "$(command -v php)" ]] && [ -z "$(command -v composer)" ] ; then
		curl -sL https://mirrors.cloud.tencent.com/composer/composer.phar -o /usr/local/bin/composer
		runs chmod +x /usr/local/bin/composer
	fi

	# Software source
	[ -n "$(command -v pip)" ] && runs pip config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple
	[ -n "$(command -v pip2)" ] && runs pip2 config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple
	[ -n "$(command -v pip3)" ] && runs pip3 config set global.index-url https://mirrors.ustc.edu.cn/pypi/web/simple
	[ -n "$(command -v composer)" ] && runs composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer/
	[ -n "$(command -v npm)" ] && runs npm config set registry https://registry.npm.taobao.org
	[ -n "$(command -v gem)" ] && runs gem sources -a https://gems.ruby-china.com

	# Config pip
	[[ -n "$(command -v pip)" ]] && [[ -z "$(pip list | grep pip-search)" ]] && pip install pip-search

	# Config Neovim
	[[ -n "$(command -v pip)" ]] && [[ -z "$(pip list | grep neovim)" ]] && pip install neovim
}

_config_sshd()
{
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
	sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
	sed -i "s/PermitRootLogin.*/PermitRootLogin no/g" /etc/ssh/sshd_config
	ssh-keygen -A
}

_node_env()
{
	# nodejs
	[ -z "$(command -v npm)" ] && sapt nodejs npm

	# Config node tools
	[ -n "$(command -v npm)" ] && [ -z "$(command -v yarn)" ] && npm i -g yarn bower
}

_do_default_env()
{
	# 先安装配置所需环境
	_do_install
	_config_env
	_config_ohmyzsh
	_config_pkg
	_do_clear
}

_do_check_env()
{
	echo "==> check env start <=="
	echo "==> check user ..."
	if [ -n "$(grep ${USER} /etc/passwd)" ];then
		echo "User: ${USER} Added"
	else
		echo "User: ${USER} Not found"
	fi

	if [[ -d "${HOME_DIR}/.oh-my-zsh" ]]; then
		echo "oh my zsh Added"
	else
		echo "oh my zsh Not found"
	fi
}

_do_sshd()
{
	mkdir -p /run/sshd

    if [[ ${ENABLE_SSHD} == "true" ]]; then
        echo "======================================================================"
        echo "You can now connect to this container via SSH using:					"
        echo "    ssh ${USER}@HOST -p port 											"
        echo "Enter the ${USER} password => '${PASSWD}' when prompted				"
        echo "Please remember to change the above password as soon as possible!		"
        echo "======================================================================"
        echo "		        Boxs ssh is Running 								    "
        echo "======================================================================"
        exec /usr/sbin/sshd -D -e
    fi
}

_do_run_vnc()
{
	/opt/noVNC/utils/launch.sh --vnc 0.0.0.0:5901
}

_do_clear()
{
	## Clean Container
	apt autoremove -y
	apt-get clean all
	rm -fr /var/lib/apt/lists/*
    rm -fr /tmp/*
}

if [[ -n "$1" ]]; then
	case $1 in
		install )
			_do_install $@
			;;
		node)
			_node_env
			;;
		config_vnc)
			_config_vnc
			;;
		clear )
			_do_clear
			;;
		check)
			_do_check_env $@
			;;
		*|-h|--help )
			echo " Boxs Env Config

"
			;;
	esac
else
	_do_default_env
fi

## Fix environment
# https://github.com/knownsec/ksubdomain
# ln -s /lib/libpcap.so.1.10.0 /lib/libpcap.so.0.8
