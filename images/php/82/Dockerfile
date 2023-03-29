FROM ghcr.io/dockenv/alpine:edge

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='PHP 8.2.0'

ENV PHP_VER=82

RUN echo "https://repo.huaweicloud.com/alpine/edge/testing" >> /etc/apk/repositories \
    && apk add --no-cache php82-bcmath php82-bz2 php82-calendar php82-ctype php82-curl php82-dba php82-dom php82-embed php82-enchant php82-exif php82-ffi php82-fileinfo php82-fpm php82-ftp php82-gd php82-gettext php82-gmp php82-iconv php82-imap php82-intl php82-ldap php82-mbstring php82-mysqli php82-mysqlnd php82-odbc php82-opcache php82-openssl php82-pcntl php82-pdo php82-pdo_dblib php82-pdo_mysql php82-pdo_odbc php82-pdo_pgsql php82-pdo_sqlite php82-pecl-apcu php82-pecl-igbinary php82-pecl-redis php82-pecl-uploadprogress php82-pecl-xdebug php82-pecl-xhprof php82-pecl-xhprof-assets php82-pecl-yaml php82-pgsql php82-phar php82-posix php82-pspell php82-session php82-shmop php82-simplexml php82-snmp php82-soap php82-sockets php82-sodium php82-sqlite3 php82-sysvmsg php82-sysvsem php82-sysvshm php82-tidy php82-tokenizer php82-xml php82-xmlreader php82-xmlwriter php82-xsl php82-zip \
    && mv /usr/bin/php${PHP_VER} /usr/bin/php \
    && mv /usr/sbin/php-fpm${PHP_VER} /usr/bin/php-fpm \
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
    && sed -i "s#^pm.max_children.*#pm.max_children = 32#" /etc/php${PHP_VER}/php-fpm.d/*.conf \
    && sed -i "s#^listen =.*#listen = 0.0.0.0:9000#" /etc/php${PHP_VER}/php-fpm.d/*.conf

EXPOSE 9000
CMD ["php-fpm","--nodaemonize"]
