FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:3.12

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

# conflict php7-pecl-gmagick php7-pecl-imagick

RUN apk add --no-cache php7 php7-bcmath php7-brotli php7-bz2 php7-calendar php7-cgi php7-ctype php7-curl php7-dba php7-dbg \
		php7-dev php7-dbg php7-dom php7-enchant php7-exif php7-fileinfo php7-fpm php7-ftp php7-gd php7-gettext php7-gmp \
		php7-iconv php7-imap php7-intl php7-json php7-ldap php7-maxminddb php7-mbstring php7-mysqli php7-mysqlnd php7-odbc \
		php7-openssl php7-pcntl php7-pdo php7-pdo_dblib php7-pdo_mysql php7-pdo_pgsql php7-pdo_sqlite php7-pear \
		php7-pecl-amqp php7-pecl-event  php7-pecl-igbinary php7-pecl-imagick php7-pecl-imagick-dev php7-pecl-mcrypt \
		php7-pecl-memcache php7-pecl-memcached php7-pecl-msgpack php7-pecl-oauth php7-pecl-protobuf php7-pecl-psr \
		php7-pecl-redis php7-pecl-uuid php7-pecl-xdebug php7-pecl-xhprof php7-pecl-yaml php7-pecl-zmq php7-pgsql php7-phar \
		php7-phpdbg php7-posix php7-pspell php7-recode php7-session php7-shmop php7-simplexml php7-snmp php7-soap \
		php7-sockets php7-sodium php7-sqlite3 php7-sysvmsg php7-sysvsem php7-sysvshm php7-tidy php7-tokenizer php7-wddx \
		php7-xml php7-xmlreader php7-xmlrpc php7-xmlwriter php7-xsl php7-zip composer \
	&& composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer

WORKDIR /app