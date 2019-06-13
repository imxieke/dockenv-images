#!/usr/bin/env bash
PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:/usr/games"
export PATH

#Config Veriable
XCLOUD_REPO="https://git.coding.net/imxieke/XCloud.git"
XCLOUD_RUN_DIR="/var/www/html/Cloud"
TTYD_REPO="https://git.coding.net/tsl0922/ttyd.git"
#TTYD_REPO="https://github.com/tsl0922/ttyd.git"

	Install_env{
		apt-get install -y build-essential gcc g++ cpp cmake make pkg-config automake \
		autoconf libwebsockets-dev libjson-c-dev libssl-dev libjson-c2 curl unzip wget zsh vim git apt-utils apt-transport-https ca-certificates
	}

	Install_ttyd{
		git clone $TTYD_REPO /tmp/ttyd
		mkdir -p /tmp/ttyd/build
		cd /tmp/ttyd/build
		cmake .. && make && make install
		cd ~ && rm -fr /tmp/ttyd
	}


	Install_XCloud{
		git clone $XCLOUD_REPO $XCLOUD_RUN_DIR && \
		chmod 777 -R $XCLOUD_RUN_DIR && \
		 rm -fr /var/www/html/Cloud/.git
	}