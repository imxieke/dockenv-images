#!/usr/bin/env bash

msgpack(){
	cd /tmp/phpbuild
	PKG_NAME="msgpack"
	PKG_VER="2.0.2"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install 
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

yaml(){
	cd /tmp/phpbuild
	PKG_NAME="yaml"
	PKG_VER="2.0.2"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install 
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

yar(){
	cd /tmp/phpbuild
	PKG_NAME="yar"
	PKG_VER="2.0.4"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure --enable-msgpack && make -j4 && make install 
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

mongodb(){
	# wget http://pecl.php.net/get/mongodb-1.5.1.tgz
	cd /tmp/phpbuild
	PKG_NAME='mongodb'
	PKG_VER="1.5.1"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install 
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

redis(){
	cd /tmp/phpbuild
	PKG_NAME="redis"
	PKG_VER="4.1.0"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install 
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

rar(){
	cd /tmp/phpbuild
	PKG_NAME="rar"
	PKG_VER="4.0.0"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
	# wget https://pecl.php.net/get/rar-4.0.0.tgz
}

swoole(){
	cd /tmp/phpbuild
	PKG_NAME="swoole"
	PKG_VER="4.0.1"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

mcrypt(){
	cd /tmp/phpbuild
	PKG_NAME="mcrypt"
	PKG_VER="1.0.1"
	# wget https://pecl.php.net/get/mcrypt-1.0.1.tgz
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/7.2/fpm/conf.d/${PKG_NAME}.ini
}

ioncube(){
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/ioncube/ioncube_loader_lin_7.2.so -O /usr/lib/php/20170718/ioncube.so
	echo "zend_extension = ioncube.so" >> /etc/php/7.2/cli/php.ini
	echo "zend_extension = ioncube.so" >> /etc/php/7.2/fpm/php.ini
}

install_ext(){

	apt update -y --fix-missing
	apt install -y apt-utils
    apt install -y --no-install-recommends  nginx php7.2-fpm php-memcache php-memcached php7.2-dev \
        php7.2-bcmath php7.2-bz2 php7.2-curl php7.2-dba php7.2-enchant php7.2-gd php7.2-gmp php7.2-imap \
        php7.2-intl php7.2-json php7.2-ldap php7.2-zip php7.2-mbstring php7.2-mysql  php7.2-odbc php7.2-pgsql \
        php7.2-readline php7.2-recode php7.2-soap php7.2-sqlite3 php7.2-tidy php7.2-xml php7.2-xmlrpc php7.2-xsl \
        php7.2-zip libmcrypt-dev wget make g++ ca-certificates libyaml-dev
    rm -fr /etc/nginx/nginx.conf
    rm -fr /etc/nginx/conf.d/*
    mkdir -p /run/nginx/
    chmod 755 -R /var/www
    chown -R www-data:www-data /var/www
    chmod +x /bin/phpenv
    apt autoremove -y
    apt-get clean all
    rm -fr /var/lib/apt/lists/*

	mkdir -p /tmp/phpbuild
	# msgpack
	yaf
	yaml
	# yar
	mongodb
	redis
	rar
	swoole
	mcrypt
	ioncube
	apt purge -y g++ make wget
	rm -fr /tmp/*
}

install_ext
echo "
#!/usr/bin/env bash
service php7.2-fpm start >> /tmp/phpenv.log
service nginx start >> /tmp/phpenv.log
tail -f /var/log/nginx/access.log" > /bin/phpenv

chmod +x /bin/phpenv
