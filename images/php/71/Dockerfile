FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:3.7

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

RUN apk add --no-cache php7 php7-amqp php7-bcmath php7-bz2 php7-calendar php7-ctype php7-curl php7-dba php7-dev php7-dom \
		php7-enchant php7-exif php7-fileinfo php7-fpm php7-ftp php7-gd php7-gettext php7-gmp php7-iconv php7-imagick \
		php7-imagick-dev php7-imap php7-intl php7-json php7-ldap php7-mbstring php7-mcrypt php7-memcached php7-mysqli \
		php7-mysqlnd php7-oauth php7-odbc php7-openssl php7-pcntl php7-pdo php7-pdo_dblib php7-pdo_mysql php7-pdo_odbc \
		php7-pdo_pgsql php7-pdo_sqlite php7-pear php7-pgsql php7-phar php7-posix php7-pspell php7-recode php7-redis \
		php7-session php7-shmop php7-simplexml php7-snmp php7-soap php7-sockets php7-sqlite3 php7-ssh2 php7-sysvmsg \
		php7-sysvsem php7-sysvshm php7-tidy php7-tokenizer php7-wddx php7-xml php7-xmlreader php7-xmlrpc php7-xmlwriter \
		php7-xsl php7-zip php7-zmq composer \
    && composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer

WORKDIR /app