#!/usr/bin/env bash

if [[ ${USER} == "" ]]; then
	USER="cmdide"
fi

if [[ ${PASSWD} = "" ]]; then
	PASSWD="cmdide"
fi

build(){
	apt update -y --fix-missing
    apt install -y --no-install-recommends openssh-server openssh-sftp-server pwgen supervisor sudo git zsh neovim wget curl unzip whois \
    	golang nodejs npm python python3 python-pip python3-pip mariadb-client mongodb-clients redis-server memcached sqlite3 libsqlite3-dev \
    	beanstalkd net-tools apt-transport-https  make cmake g++ software-properties-common
}

# Set $USER and root user Password
user(){
	USER=$1
	PASSWD=$2
    useradd -d /home/${USER} -m -s /bin/zsh ${USER}
    echo "${USER}:${PASSWD}" | chpasswd
    echo "root:${PASSWD}" | chpasswd
    echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
    chmod -R 755 $HOME_DIR
    chown -R ${USER}:${USER} $HOME_DIR
}

# Permision for remote connect Container via ssh
sshd(){
	HOME_DIR=$1
	echo "########## Config sshd #################"
	mkdir -p /var/run/sshd
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config
	sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
	sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
	ssh-keygen -A
	echo "#########Config End###########"
	mkdir -p /root/.ssh/
	mkdir -p $HOME_DIR/.ssh/
	touch /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
    touch $HOME_DIR/.ssh/authorized_keys
    chmod 600 $HOME_DIR/.ssh/authorized_keys
}

ohmyzsh(){
	HOME_DIR=$1
	echo "Cloning ohmyzsh to $HOME_DIR"
	#sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ${HOME_DIR}/.oh-my-zsh
    cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc
}

#golang env
golang(){
	echo "Setting Golang Environment"
	mkdir -p $HOME_DIR/.go/bin
	mkdir -p $HOME_DIR/.go/src
	mkdir -p $HOME_DIR/.go/pkg
	echo "export GOBIN="$HOME_DIR/.go/bin"" >> $HOME_DIR/.zshrc
	echo "export GOPATH="$HOME_DIR/.go/"" 	>> $HOME_DIR/.zshrc
}

set_node(){
	echo "Set Node Environment"
	# sudo -Hu ${USER} npm config set registry https://registry.npm.taobao.org
	echo "registry=https://registry.npm.taobao.org" > ${HOME_DIR}/.npmrc
	# echo "Install yarn"
	# npm install -g yarn
	# npm install -g  webpack
	# npm install -g  bower
	# npm install -g  gulp-cli
	# npm install -g  grunt-cli
}

set_php(){
	USER=$1
	# Set Some PHP CLI Settings
	sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/cli/php.ini
	sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/cli/php.ini
	sudo sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/cli/php.ini
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/pkgs/zray-standalone-php72.tar.gz -O - | sudo tar -xzf - -C /opt
	chown -R ${USER}:${USER} /opt/zray
	ln -sf /opt/zray/zray.ini /etc/php/7.2/cli/conf.d/zray.ini
	ln -sf /opt/zray/zray.ini /etc/php/7.2/fpm/conf.d/zray.ini
	ln -sf /opt/zray/lib/zray.so /usr/lib/php/20170718/zray.so

	# Current is 1.6.5 version
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/pkgs/composer.phar -O /bin/composer
	chmod +x /bin/composer
	sudo -Hu ${USER} composer config -g repo.packagist composer https://packagist.laravel-china.org

	# WordPress Cli
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/pkgs/wp-cli.phar -O /bin/wp-cli
	chmod +x /bin/composer
	
	#Adminer php mysql manager
	mkdir -p /var/www/tools
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/code/adminer-4.6.3.php -O /var/www/tools/adminer.php
	#vim /etc/nginx/sites-available/homestead.app
	#insert new location below location /:
	#location /ZendServer {
	#        try_files $uri $uri/ /ZendServer/index.php?$args;
	#}
}

mailhog(){
	wget --quiet -O /usr/local/bin/mailhog https://coding.net/u/imxieke/p/attachment/git/raw/master/pkgs/MailHog_linux_amd64_V1.0.0
	chmod +x /usr/local/bin/mailhog
}

webeditor(){
	NAME="kodexplorer"
	VER="4.35"
	mkdir -p /var/www/ide
	cd /var/www/ide
	wget https://mirrors.cs.edu.rs/PHP/${NAME}${VER}.zip
	unzip ${NAME}${VER}.zip 
	rm -fr ${NAME}${VER}.zip
	chmod 755 -R /var/www
	chown www-data:www-data -R /var/www
}

clean_env(){
	USER=$1
	HOME_DIR=$2
	apt autoremove -y
    apt-get clean all
    rm -fr /var/lib/apt/lists/*
	chown -R ${USER}:${USER} ${HOME_DIR}
}

install_ext(){
	USER=$1
	PASSWD=$2
	HOME_DIR=$3
	build
	user 	${USER} ${PASSWD}
	sshd 	${HOME_DIR}
	ohmyzsh ${HOME_DIR}
	golang 	${HOME_DIR}
	set_node ${HOME_DIR}
	set_php ${USER}
	mailhog
	webeditor
	clean_env ${USER} ${HOME_DIR}
}

install_ext ${USER} ${PASSWD} ${HOME_DIR}