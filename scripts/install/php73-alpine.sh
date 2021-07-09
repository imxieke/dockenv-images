#!/usr/bin/env sh

sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# depend
apk add --update alpine-sdk
apk add linux-headers autoconf gcc g++ libevent libevent-dev make libuser  openssh

apk add --no-cache php7-bcmath php7-brotli php7-bz2 php7-calendar php7-cgi php7-ctype \
        php7-curl php7-dba php7-dbg php7-dev php7-embed php7-dom php7-enchant php7-exif php7-ffi php7-fileinfo \
        php7-fpm php7-ftp php7-gd php7-gettext php7-gmp php7-iconv php7-imap php7-intl php7-json  php7-ldap php7-litespeed \
        php7-mbstring php7-mysqli php7-mysqlnd php7-odbc php7-opcache php7-openssl php7-pcntl php7-pdo php7-pdo_dblib \
        php7-pdo_mysql php7-pdo_odbc php7-pdo_pgsql php7-pdo_sqlite php7-pear php7-pecl-amqp php7-pecl-apcu php7-pecl-ast \
        php7-pecl-couchbase php7-pecl-event php7-pecl-gmagick php7-pecl-igbinary php7-pecl-imagick  php7-pecl-imagick-dev \
        php7-pecl-lzf php7-pecl-mailparse php7-pecl-maxminddb php7-pecl-mcrypt php7-pecl-memcache php7-pecl-memcached \
        php7-pecl-mongodb php7-pecl-msgpack php7-pecl-oauth php7-pecl-protobuf php7-pecl-psr php7-pecl-redis php7-pecl-ssh2 \
        php7-pecl-timezonedb020 php7-pecl-uploadprogress php7-pecl-uploadprogress-doc php7-pecl-uuidphp7-pecl-vips \
        php7-pecl-xdebug php7-pecl-xhprof php7-pecl-xhprof-assets php7-pecl-yaml php7-pecl-zmq php7-pgsql php7-phalcon \
        php7-phar php7-phpdbg php7-posix php7-pspell php7-session php7-shmop php7-simplexml php7-snmp php7-soap php7-sockets\
        php7-sodium php7-sqlite3 php7-static php7-sysvmsg php7-sysvsem php7-sysvshm php7-tidy php7-tokenizer php7-xml  \
        php7-xmlreader php7-xmlrpc php7-xmlwriter php7-xsl php7-zip

url -sS https://getcomposer.org/installer |php7

# /etc/php7/conf.d/20_xdebug.ini
echo "xdebug.remote_host = ${LOCAL_IP_ADD}" >> /etc/php7/conf.d/20_xdebug.ini
echo "xdebug.idekey = PHPSTORM" >> /etc/php7/conf.d/20_xdebug.ini
echo "xdebug.remote_autostart = off" >> /etc/php7/conf.d/20_xdebug.ini

# extends
pecl install swoole
pecl install libevent

addgroup -S topone4tvs && adduser -S -G topone4tvs topone4tvs
chown -R topone4tvs:topone4tvs /var/www/

apk add openssh
ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key
sed -i -e "s/#HostKey \/etc\/ssh\/ssh_host_rsa_key/HostKey \/etc\/ssh\/ssh_host_rsa_key/g" /etc/ssh/sshd_config
ssh-keygen -t rsa
touch ~/.ssh/authorized_keys

EXPOSE 9000
