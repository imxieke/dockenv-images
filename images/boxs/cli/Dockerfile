FROM ghcr.io/dockenv/debian:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

RUN apt update -y --fix-missing \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        sudo lsb-release ca-certificates apt-transport-https software-properties-common gnupg2 wget curl \
    && echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" | tee /etc/apt/sources.list.d/sury-php.list \
    && wget -qO - https://packages.sury.org/php/apt.gpg | apt-key add - \
    && apt update -y \
    && apt-get install -y --no-install-recommends --no-install-suggests php5.6 php5.6-amqp php5.6-apcu php5.6-bcmath php5.6-bz2 php5.6-cgi php5.6-cli php5.6-common php5.6-curl php5.6-dba php5.6-dev php5.6-enchant php5.6-fpm php5.6-gd php5.6-geoip php5.6-gmp php5.6-gnupg php5.6-grpc php5.6-http php5.6-igbinary php5.6-imagick php5.6-imap php5.6-inotify php5.6-intl php5.6-json php5.6-ldap php5.6-lz4 php5.6-mailparse php5.6-mbstring php5.6-mcrypt php5.6-memcache php5.6-memcached php5.6-mongo php5.6-mongodb php5.6-msgpack php5.6-mysql php5.6-oauth php5.6-odbc php5.6-opcache php5.6-pgsql php5.6-phalcon3 php5.6-propro php5.6-protobuf php5.6-ps php5.6-pspell php5.6-radius php5.6-raphf php5.6-readline php5.6-recode php5.6-redis php5.6-rrd php5.6-smbclient php5.6-snmp php5.6-soap php5.6-solr php5.6-sqlite3 php5.6-ssh2 php5.6-stomp php5.6-tidy php5.6-uploadprogress php5.6-xdebug php5.6-xhprof php5.6-xml php5.6-xmlrpc php5.6-xsl php5.6-yaml php5.6-zip php5.6-zmq php5.6-zstd \
    && apt-get install -y --no-install-recommends --no-install-suggests php7.4 php7.4-amqp php7.4-apcu php7.4-apcu-bc php7.4-ast php7.4-bcmath php7.4-bz2 php7.4-cgi php7.4-cli php7.4-common php7.4-curl php7.4-dba php7.4-decimal php7.4-dev php7.4-ds php7.4-enchant php7.4-fpm php7.4-gd php7.4-geoip php7.4-gmp php7.4-gnupg php7.4-grpc php7.4-http php7.4-igbinary php7.4-imagick php7.4-imap php7.4-inotify php7.4-intl php7.4-json php7.4-ldap php7.4-lz4 php7.4-mailparse php7.4-maxminddb php7.4-mbstring php7.4-mcrypt php7.4-memcache php7.4-memcached php7.4-mongodb php7.4-msgpack php7.4-mysql php7.4-oauth php7.4-odbc php7.4-opcache php7.4-pcov php7.4-pgsql php7.4-phalcon4 php7.4-pinba php7.4-propro php7.4-protobuf php7.4-ps php7.4-pspell php7.4-psr php7.4-radius php7.4-raphf php7.4-readline php7.4-redis php7.4-rrd php7.4-smbclient php7.4-snmp php7.4-soap php7.4-solr php7.4-sqlite3 php7.4-ssh2 php7.4-stomp php7.4-swoole php7.4-sybase php7.4-tideways php7.4-tidy php7.4-uopz php7.4-uploadprogress php7.4-uuid php7.4-vips php7.4-xdebug php7.4-xhprof php7.4-xml php7.4-xmlrpc php7.4-xsl php7.4-yaml php7.4-zip php7.4-zmq php7.4-zstd \
    && apt-get install -y --no-install-recommends --no-install-suggests php8.0 php8.0-amqp php8.0-apcu php8.0-ast php8.0-bcmath php8.0-bz2 php8.0-cgi php8.0-cli php8.0-common php8.0-curl php8.0-dba php8.0-decimal php8.0-dev php8.0-ds php8.0-enchant php8.0-fpm php8.0-gd php8.0-gmp php8.0-gnupg php8.0-grpc php8.0-http php8.0-igbinary php8.0-imagick php8.0-imap php8.0-inotify php8.0-intl php8.0-ldap php8.0-lz4 php8.0-mailparse php8.0-maxminddb php8.0-mbstring php8.0-mcrypt php8.0-memcache php8.0-memcached php8.0-mongodb php8.0-msgpack php8.0-mysql php8.0-oauth php8.0-odbc php8.0-opcache php8.0-pcov php8.0-pgsql php8.0-protobuf php8.0-ps php8.0-pspell php8.0-psr php8.0-raphf php8.0-readline php8.0-redis php8.0-rrd php8.0-smbclient php8.0-snmp php8.0-soap php8.0-solr php8.0-sqlite3 php8.0-ssh2 php8.0-swoole php8.0-sybase php8.0-tidy php8.0-uopz php8.0-uploadprogress php8.0-uuid php8.0-vips php8.0-xdebug php8.0-xhprof php8.0-xml php8.0-xmlrpc php8.0-xsl php8.0-yaml php8.0-zip php8.0-zmq php8.0-zstd \
    && apt-get install -y --no-install-recommends --no-install-suggests php8.1 php8.1-amqp php8.1-apcu php8.1-ast php8.1-bcmath php8.1-bz2 php8.1-cgi php8.1-cli php8.1-common php8.1-curl php8.1-dba php8.1-decimal php8.1-dev php8.1-ds php8.1-enchant php8.1-fpm php8.1-gd php8.1-gmp php8.1-gnupg php8.1-grpc php8.1-igbinary php8.1-imagick php8.1-imap php8.1-inotify php8.1-intl php8.1-ldap php8.1-lz4 php8.1-mailparse php8.1-maxminddb php8.1-mbstring php8.1-mcrypt php8.1-memcache php8.1-memcached php8.1-mongodb php8.1-msgpack php8.1-mysql php8.1-oauth php8.1-odbc php8.1-opcache php8.1-pcov php8.1-pgsql php8.1-protobuf php8.1-ps php8.1-pspell php8.1-psr php8.1-raphf php8.1-readline php8.1-redis php8.1-rrd php8.1-smbclient php8.1-snmp php8.1-soap php8.1-solr php8.1-sqlite3 php8.1-ssh2 php8.1-swoole php8.1-sybase php8.1-tidy php8.1-uopz php8.1-uploadprogress php8.1-uuid php8.1-vips php8.1-xdebug php8.1-xhprof php8.1-xml php8.1-xmlrpc php8.1-xsl php8.1-yaml php8.1-zip php8.1-zmq php8.1-zstd \
    # Custom PHP Configure
    && sed -i 's#;curl.cainfo.*#curl.cainfo = /etc/ssl/certs/ca-certificates.crt#g' /etc/php/*/*/php.ini \
    && sed -i 's#;date.timezone.*#date.timezone = Asia/Shanghai#g' /etc/php/*/*/php.ini \
    && sed -i 's#max_file_uploads.*#max_file_uploads = 512#g' /etc/php/*/*/php.ini \
    && sed -i 's#post_max_size.*#post_max_size = 512M#g' /etc/php/*/*/php.ini \
    && sed -i 's#upload_max_filesize.*#upload_max_filesize = 512M#g' /etc/php/*/*/php.ini \
    && sed -i 's#memory_limit.*#memory_limit = 512M#g' /etc/php/*/*/php.ini \
    && sed -i 's#;cgi.fix_pathinfo.*#cgi.fix_pathinfo=0#g' /etc/php/*/*/php.ini \
    && sed -i 's#display_errors.*#display_errors = On#g' /etc/php/*/*/php.ini \
    && sed -i 's#error_reporting.*#error_reporting = E_ALL#g' /etc/php/*/*/php.ini \
    && rm -fr /tmp/* \
    && apt autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && rm -fr /var/lib/apt/lists/*
