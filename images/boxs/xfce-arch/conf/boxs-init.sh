#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-10-26 13:29:54
 # @LastEditTime: 2021-10-26 13:33:14
 # @LastEditors: Cloudflying
 # @Description: XFCE Boxs Environment Init
 # @FilePath: /dockenv/images/boxs/xfce-arch/conf/boxs-init.sh
###

#golang env
init_golang(){
	echo "Setting Golang Environment"
	mkdir -p $HOME_DIR/.go/bin
	mkdir -p $HOME_DIR/.go/src
	mkdir -p $HOME_DIR/.go/pkg
	echo "export GOBIN="$HOME_DIR/.go/bin"" >> $HOME_DIR/.zshrc
	echo "export GOPATH="$HOME_DIR/.go/"" 	>> $HOME_DIR/.zshrc
}

init_node(){
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

init_php(){
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
