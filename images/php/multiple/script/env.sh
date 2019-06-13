#!/usr/bin/env bash
export DEBIAN_FRONTEND=noninteractive

# Update Package && System
apt-get update -y --fix-missing
apt-get -y upgrade
apt-get install -y software-properties-common wget curl locales make gcc g++ gawk libyaml-dev

# Force Locale
echo "LC_ALL=en_US.UTF-8" >> /etc/default/locale

# Install Some PPAs
apt-add-repository ppa:nginx/development -y
apt-add-repository ppa:ondrej/php -y

#Install WebServer
apt-get install -y nginx

# Install PHP Stuffs
# PHP 7.3
# apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
# php7.3-fpm php7.3-cli php7.3-dev php7.3-pgsql php7.3-sqlite3 php7.3-gd php7.3-curl php7.3-imap \
# php7.3-mysql php7.3-mbstring php7.3-xml php7.3-zip php7.3-bcmath php7.3-soap php7.3-intl php7.3-readline

# PHP 7.2
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php7.2-fpm php7.2-cli php7.2-dev php7.2-pgsql php7.2-sqlite3 php7.2-gd php7.2-curl php7.2-memcached php7.2-imap \
php7.2-mysql php7.2-mbstring php7.2-xml php7.2-zip php7.2-bcmath php7.2-soap php7.2-intl php7.2-readline php7.2-ldap \
php-xdebug php-pear

# PHP 7.1
# apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
# php7.1-fpm php7.1-cli php7.1-dev php7.1-pgsql php7.1-sqlite3 php7.1-gd php7.1-curl php7.1-memcached php7.1-imap php7.1-mysql \
# php7.1-mbstring php7.1-xml php7.1-zip php7.1-bcmath php7.1-soap php7.1-intl php7.1-readline

# PHP 7.0
# apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
# php7.0-fpm php7.0-cli php7.0-dev php7.0-pgsql php7.0-sqlite3 php7.0-gd php7.0-curl php7.0-memcached \
# php7.0-imap php7.0-mysql php7.0-mbstring php7.0-xml php7.0-zip php7.0-bcmath php7.0-soap php7.0-intl php7.0-readline

# PHP 5.6
apt-get install -y --allow-downgrades --allow-remove-essential --allow-change-held-packages \
php5.6-fpm php5.6-cli php5.6-dev php5.6-pgsql php5.6-sqlite3 php5.6-gd php5.6-curl php5.6-memcached \
php5.6-imap php5.6-mysql php5.6-mbstring php5.6-xml php5.6-zip php5.6-bcmath php5.6-soap php5.6-intl \
php5.6-readline php5.6-mcrypt

# Setup Some PHP-FPM Options
# echo "xdebug.remote_enable = 1" >> /etc/php/7.3/mods-available/xdebug.ini
# echo "xdebug.remote_connect_back = 1" >> /etc/php/7.3/mods-available/xdebug.ini
# echo "xdebug.remote_port = 9000" >> /etc/php/7.3/mods-available/xdebug.ini
# echo "xdebug.max_nesting_level = 512" >> /etc/php/7.3/mods-available/xdebug.ini
# echo "opcache.revalidate_freq = 0" >> /etc/php/7.3/mods-available/opcache.ini

echo "xdebug.remote_enable = 1" >> /etc/php/7.2/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/7.2/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/7.2/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/7.2/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/7.2/mods-available/opcache.ini

# echo "xdebug.remote_enable = 1" >> /etc/php/7.1/mods-available/xdebug.ini
# echo "xdebug.remote_connect_back = 1" >> /etc/php/7.1/mods-available/xdebug.ini
# echo "xdebug.remote_port = 9000" >> /etc/php/7.1/mods-available/xdebug.ini
# echo "xdebug.max_nesting_level = 512" >> /etc/php/7.1/mods-available/xdebug.ini
# echo "opcache.revalidate_freq = 0" >> /etc/php/7.1/mods-available/opcache.ini

# echo "xdebug.remote_enable = 1" >> /etc/php/7.0/mods-available/xdebug.ini
# echo "xdebug.remote_connect_back = 1" >> /etc/php/7.0/mods-available/xdebug.ini
# echo "xdebug.remote_port = 9000" >> /etc/php/7.0/mods-available/xdebug.ini
# echo "xdebug.max_nesting_level = 512" >> /etc/php/7.0/mods-available/xdebug.ini
# echo "opcache.revalidate_freq = 0" >> /etc/php/7.0/mods-available/opcache.ini

echo "xdebug.remote_enable = 1" >> /etc/php/5.6/mods-available/xdebug.ini
echo "xdebug.remote_connect_back = 1" >> /etc/php/5.6/mods-available/xdebug.ini
echo "xdebug.remote_port = 9000" >> /etc/php/5.6/mods-available/xdebug.ini
echo "xdebug.max_nesting_level = 512" >> /etc/php/5.6/mods-available/xdebug.ini
echo "opcache.revalidate_freq = 0" >> /etc/php/5.6/mods-available/opcache.ini

# sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.3/fpm/php.ini
# sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.3/fpm/php.ini
# sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.3/fpm/php.ini
# sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.3/fpm/php.ini
# sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.3/fpm/php.ini
# sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.3/fpm/php.ini
# sed -i "s/max_file_uploads = .*/max_file_uploads = 5120/" /etc/php/7.3/fpm/php.ini
# sed -i "s/;date.timezone.*/date.timezone = RPC/" /etc/php/7.3/fpm/php.ini

# printf "[openssl]\n" | tee -a /etc/php/7.3/fpm/php.ini
# printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini

# printf "[curl]\n" | tee -a /etc/php/7.3/fpm/php.ini
# printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.3/fpm/php.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.2/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.2/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.2/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.2/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.2/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.2/fpm/php.ini
sed -i "s/max_file_uploads = .*/max_file_uploads = 5120/" /etc/php/7.2/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = RPC/" /etc/php/7.2/fpm/php.ini

printf "[openssl]\n" | tee -a /etc/php/7.2/fpm/php.ini
printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.2/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/7.2/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.2/fpm/php.ini

# sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.1/fpm/php.ini
# sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.1/fpm/php.ini
# sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.1/fpm/php.ini
# sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.1/fpm/php.ini
# sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.1/fpm/php.ini
# sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.1/fpm/php.ini
# sed -i "s/max_file_uploads = .*/max_file_uploads = 5120/" /etc/php/7.1/fpm/php.ini
# sed -i "s/;date.timezone.*/date.timezone = RPC/" /etc/php/7.1/fpm/php.ini

# printf "[openssl]\n" | tee -a /etc/php/7.1/fpm/php.ini
# printf "openssl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.1/fpm/php.ini

# printf "[curl]\n" | tee -a /etc/php/7.1/fpm/php.ini
# printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.1/fpm/php.ini

# sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/7.0/fpm/php.ini
# sed -i "s/display_errors = .*/display_errors = On/" /etc/php/7.0/fpm/php.ini
# sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/7.0/fpm/php.ini
# sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/7.0/fpm/php.ini
# sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/7.0/fpm/php.ini
# sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/7.0/fpm/php.ini
# sed -i "s/max_file_uploads = .*/max_file_uploads = 5120/" /etc/php/7.0/fpm/php.ini
# sed -i "s/;date.timezone.*/date.timezone = RPC/" /etc/php/7.0/fpm/php.ini

# printf "[curl]\n" | tee -a /etc/php/7.0/fpm/php.ini
# printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/7.0/fpm/php.ini

sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php/5.6/fpm/php.ini
sed -i "s/display_errors = .*/display_errors = On/" /etc/php/5.6/fpm/php.ini
sed -i "s/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/" /etc/php/5.6/fpm/php.ini
sed -i "s/memory_limit = .*/memory_limit = 512M/" /etc/php/5.6/fpm/php.ini
sed -i "s/upload_max_filesize = .*/upload_max_filesize = 100M/" /etc/php/5.6/fpm/php.ini
sed -i "s/post_max_size = .*/post_max_size = 100M/" /etc/php/5.6/fpm/php.ini
sed -i "s/max_file_uploads = .*/max_file_uploads = 5120/" /etc/php/5.6/fpm/php.ini
sed -i "s/;date.timezone.*/date.timezone = RPC/" /etc/php/5.6/fpm/php.ini

printf "[curl]\n" | tee -a /etc/php/5.6/fpm/php.ini
printf "curl.cainfo = /etc/ssl/certs/ca-certificates.crt\n" | tee -a /etc/php/5.6/fpm/php.ini

cat > /etc/nginx/fastcgi_params << EOF
fastcgi_param	QUERY_STRING		\$query_string;
fastcgi_param	REQUEST_METHOD		\$request_method;
fastcgi_param	CONTENT_TYPE		\$content_type;
fastcgi_param	CONTENT_LENGTH		\$content_length;
fastcgi_param	SCRIPT_FILENAME		\$request_filename;
fastcgi_param	SCRIPT_NAME			\$fastcgi_script_name;
fastcgi_param	REQUEST_URI			\$request_uri;
fastcgi_param	DOCUMENT_URI		\$document_uri;
fastcgi_param	DOCUMENT_ROOT		\$document_root;
fastcgi_param	SERVER_PROTOCOL		\$server_protocol;
fastcgi_param	GATEWAY_INTERFACE	CGI/1.1;
fastcgi_param	SERVER_SOFTWARE		nginx/\$nginx_version;
fastcgi_param	REMOTE_ADDR			\$remote_addr;
fastcgi_param	REMOTE_PORT			\$remote_port;
fastcgi_param	SERVER_ADDR			\$server_addr;
fastcgi_param	SERVER_PORT			\$server_port;
fastcgi_param	SERVER_NAME			\$server_name;
fastcgi_param	HTTPS				\$https if_not_empty;
fastcgi_param	REDIRECT_STATUS		200;
EOF

# Custom Config
# rm -fr /etc/nginx/nginx.conf
rm -fr /etc/nginx/sites-enabled
rm -fr /etc/nginx/sites-available

chmod 755 -R /var/www
chown -R www-data:www-data /var/www

php56() {
    update-alternatives --set php /usr/bin/php5.6
    update-alternatives --set php-config /usr/bin/php-config5.6
    update-alternatives --set phpize /usr/bin/phpize5.6
}

# php70() {
#     update-alternatives --set php /usr/bin/php7.0
#     update-alternatives --set php-config /usr/bin/php-config7.0
#     update-alternatives --set phpize /usr/bin/phpize7.0
# }

# php71() {
#     update-alternatives --set php /usr/bin/php7.1
#     update-alternatives --set php-config /usr/bin/php-config7.1
#     update-alternatives --set phpize /usr/bin/phpize7.1
# }

php72() {
    update-alternatives --set php /usr/bin/php7.2
    update-alternatives --set php-config /usr/bin/php-config7.2
    update-alternatives --set phpize /usr/bin/phpize7.2
}

# php73() {
#     update-alternatives --set php /usr/bin/php7.3
#     update-alternatives --set php-config /usr/bin/php-config7.3
#     update-alternatives --set phpize /usr/bin/phpize7.3
# }

ioncube(){
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/ioncube/ioncube_loader_lin_7.2.so -O /usr/lib/php/20170718/ioncube.so
	# wget https://coding.net/u/imxieke/p/attachment/git/raw/master/ioncube/ioncube_loader_lin_7.1.so -O /usr/lib/php/20160303/ioncube.so
	# wget https://coding.net/u/imxieke/p/attachment/git/raw/master/ioncube/ioncube_loader_lin_7.0.so -O /usr/lib/php/20151012/ioncube.so
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/ioncube/ioncube_loader_lin_5.6.so -O /usr/lib/php/20131226/ioncube.so

	echo "zend_extension = ioncube.so" >> /etc/php/7.2/cli/php.ini
	echo "zend_extension = ioncube.so" >> /etc/php/7.2/fpm/php.ini

	# echo "zend_extension = ioncube.so" >> /etc/php/7.1/cli/php.ini
	# echo "zend_extension = ioncube.so" >> /etc/php/7.1/fpm/php.ini

	# echo "zend_extension = ioncube.so" >> /etc/php/7.0/cli/php.ini
	# echo "zend_extension = ioncube.so" >> /etc/php/7.0/fpm/php.ini

	echo "zend_extension = ioncube.so" >> /etc/php/5.6/cli/php.ini
	echo "zend_extension = ioncube.so" >> /etc/php/5.6/fpm/php.ini
}

# Install PHP Extensions
yaml(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME="yaml"
	PKG_VER="2.0.2"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

yaconf(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME="yaconf"
	PKG_VER="1.0.7"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

yaf(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME="yaf"
	PKG_VER="3.0.7"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

mongodb(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME='mongodb'
	PKG_VER="1.5.1"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

redis(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME="redis"
	PKG_VER="4.1.0"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

rar(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME="rar"
	PKG_VER="4.0.0"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

swoole(){
	PHPVER=$1
	cd $BUILD_DIR
	PKG_NAME="swoole"
	PKG_VER="4.0.1"
	wget https://coding.net/u/imxieke/p/attachment/git/raw/master/src/${PKG_NAME}-${PKG_VER}.tgz
	tar zxvf ${PKG_NAME}-${PKG_VER}.tgz && cd ${PKG_NAME}-${PKG_VER}
	phpize && ./configure && make -j4 && make install
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/cli/conf.d/${PKG_NAME}.ini
	echo "extension=${PKG_NAME}.so" > /etc/php/${PHPVER}/fpm/conf.d/${PKG_NAME}.ini
	cd .. && rm -fr ${PKG_NAME}-${PKG_VER}
}

php56ext(){
	php56
	mongodb 5.6
	redis 5.6
	rar 5.6
}

# php70ext(){
# 	php70
# 	yaml 7.0
# 	yaconf 7.0
# 	yaf 7.0
# 	mongodb 7.0
# 	redis 7.0
# 	rar 7.0
# 	swoole 7.0
# }

# php71ext(){
# 	php71
# 	yaml 7.1
# 	yaconf 7.1
# 	yaf 7.1
# 	mongodb 7.1
# 	redis 7.1
# 	rar 7.1
# 	swoole 7.1
# }

php72ext(){
	php72
	yaconf 7.2
	yaf 7.2
	yaml 7.2
	mongodb 7.2
	redis 7.2
	rar 7.2
	swoole 7.2
}

# php73ext(){
# 	php73
# 	mongodb 7.3
# 	redis 7.3
# 	swoole 7.3
# }

install_ext(){
	BUILD_DIR="/tmp/phpbuild"
	mkdir -p $BUILD_DIR
	cd $BUILD_DIR
	ioncube
	php56ext
	# php70ext
	# php71ext
	php72ext
	# php73ext
}

install_ext
apt purge -y make gcc g++ gawk wget curl
rm -fr /tmp/*
apt autoremove -y
apt-get clean all
rm -fr /var/lib/apt/lists/*