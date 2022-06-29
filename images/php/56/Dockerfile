FROM ghcr.io/dockenv/alpine:3.8

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='PHP 5.6.40'

ENV PHP_VER=5

RUN apk add --no-cache php5-apcu php5-cli php5-ctype php5-curl php5-dba php5-fpm php5-bcmath php5-bz2 php5-calendar php5-dom php5-embed php5-enchant php5-exif php5-ftp php5-gd php5-gettext php5-gmp php5-iconv php5-imap php5-intl php5-json php5-ldap php5-mcrypt php5-mssql php5-mysql php5-mysqli php5-odbc php5-opcache php5-openssl php5-pcntl php5-pdo php5-pdo_dblib php5-pdo_mysql php5-pdo_odbc php5-pdo_pgsql php5-pdo_sqlite php5-pgsql php5-phar php5-posix php5-pspell php5-shmop php5-snmp php5-soap php5-sockets php5-sqlite3 php5-suhosin php5-sysvmsg php5-sysvsem php5-sysvshm php5-wddx php5-xml php5-xmlreader php5-xmlrpc php5-xsl php5-zip \
    && mv /usr/bin/php${PHP_VER} /usr/bin/php \
    && mv /usr/bin/php-fpm${PHP_VER} /usr/bin/php-fpm \
    && mv /usr/bin/phpize${PHP_VER} /usr/bin/phpize \
    && sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/display_errors = .*/display_errors = On/" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/memory_limit = .*/memory_limit = 256M/" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/date.timezone.*/date.timezone = 'Asia\/Shanghai'/" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/upload_max_filesize = .*/upload_max_filesize = 512M/" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/post_max_size = .*/post_max_size = 512M/" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/max_file_uploads =.*/max_file_uploads = 256/g" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/display_startup_errors =.*/display_startup_errors = On/g" /etc/php${PHP_VER}/php.ini \
    && sed -i "s/log_errors =.*/log_errors = On/g" /etc/php${PHP_VER}/php.ini \
    && sed -i 's/default_charset =.*/default_charset = "UTF-8"/g' /etc/php${PHP_VER}/php.ini \
    && sed -i 's/max_execution_time =.*/max_execution_time = 300/g' /etc/php${PHP_VER}/php.ini \
    && sed -i "s#^pm.max_children.*#pm.max_children = 32#" /etc/php${PHP_VER}/php-fpm.conf

EXPOSE 9000
CMD ["php-fpm","--nodaemonize"]
