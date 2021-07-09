FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:3.7

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

# conflict php7-pecl-gmagick php7-pecl-imagick

RUN apk add --no-cache php5 php5-bcmath php5-bz2 php5-calendar php5-cli php5-ctype php5-curl php5-dba php5-dbg php5-dev php5-dom \
		php5-enchant php5-exif php5-fpm php5-ftp php5-gd php5-gettext php5-gmp php5-iconv php5-imap php5-intl php5-json php5-ldap \
		php5-mcrypt php5-mssql php5-mysql php5-mysqli php5-odbc php5-openssl php5-pcntl php5-pdo php5-pdo_dblib php5-pdo_mysql \
		php5-pdo_odbc php5-pdo_pgsql php5-pdo_sqlite php5-pear php5-pgsql php5-phar php5-posix php5-pspell php5-shmop php5-snmp \
		php5-soap php5-sockets php5-sqlite3 php5-sysvmsg php5-sysvsem php5-sysvshm php5-wddx php5-xml php5-xmlreader php5-xmlrpc \
		php5-xsl php5-zip php5-zlib \
	&& mv /usr/bin/php5 /usr/bin/php \
	&& mv /usr/bin/phpize5 /usr/bin/phpize \
	&& mv /usr/bin/php-fpm5 /usr/bin/php-fpm \
	&& wget https://mirrors.cloud.tencent.com/composer/composer.phar -O /usr/bin/composer \
	&& chmod +x /usr/bin/composer \
    && composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer


WORKDIR /app