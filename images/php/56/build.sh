#!/usr/bin/env sh
###
 # @Author: Cloudflying
 # @Date: 2021-11-13 14:35:21
 # @LastEditTime: 2021-11-14 13:08:45
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/php/56/build.sh
###

CORES=$(grep -c '^processor' /proc/cpuinfo)
ARCH=$(uname -m)

ext_url='https://hk.mirrors.xieke.org/Src/php-exts'

PHP_EXT_AMQP_VER=1.11.0RC1
PHP_EXT_CRYPTO_VER=0.3.2
PHP_EXT_EV_VER=1.1.5
PHP_EXT_EVENT_VER=3.0.7RC1
PHP_EXT_GNUPG_VER=1.5.0
PHP_EXT_HPROSE_VER=1.8.0
PHP_EXT_IGBINARY_VER=2.0.8
PHP_EXT_IMAGICK_VER=3.6.0RC1
PHP_EXT_LEVELDB_VER=0.1.5
PHP_EXT_MSGPACK_VER=0.5.7
PHP_EXT_MEMCACHE_VER=3.0.8
PHP_EXT_MEMCACHED_VER=2.2.0RC1
PHP_EXT_MONGODB_VER=1.7.5
PHP_EXT_PROTOBUF_VER=3.12.4
PHP_EXT_SQLSRV_VER=3.0.1
PHP_EXT_PDO_SQLSRV_VER=3.0.1
PHP_EXT_RAR_VER=4.2.0
PHP_EXT_RDKAFKA_VER=4.1.2
PHP_EXT_REDIS_VER=4.3.0
PHP_EXT_SCRYPT_VER=1.4.2
PHP_EXT_SMBCLIENT_VER=1.0.6
PHP_EXT_STOMP_VER=1.0.9
PHP_EXT_SWOOLE_VER=2.0.11
PHP_EXT_XHPROF_VER=0.9.4
PHP_EXT_XDEBUG_VER=2.5.5
PHP_EXT_ZOOKEEPER_VER=0.5.0
PHP_EXT_YAC_VER=0.9.2
PHP_EXT_YAML_VER=1.3.1
PHP_EXT_SSH2_VER=0.13
PHP_EXT_YAF_VER=2.3.5
PHP_EXT_ZSTD_VER=0.11.0

apk add --no-cache --virtual .deps wget curl autoconf make gcc g++ file #> /dev/null

apk add --no-cache php5 php5-apcu php5-bcmath php5-bz2 php5-calendar php5-cgi php5-cli php5-ctype php5-curl php5-dba php5-dev \
    php5-dom php5-embed php5-enchant php5-exif php5-fpm php5-ftp php5-gd php5-gettext php5-gmp php5-iconv php5-imap php5-intl \
    php5-json php5-ldap php5-mcrypt php5-mssql php5-mysql php5-mysqli php5-odbc php5-openssl php5-pcntl php5-pdo php5-pdo_dblib \
    php5-pdo_mysql php5-opcache php5-phpdbg php5-pdo_odbc php5-pdo_pgsql php5-pdo_sqlite php5-pear php5-pgsql php5-phar php5-posix \
    php5-pspell php5-shmop php5-snmp php5-soap php5-sockets php5-sqlite3 php5-sysvmsg php5-sysvsem php5-sysvshm \
    php5-wddx php5-xml php5-xmlreader php5-xmlrpc php5-xsl php5-zip php5-zlib #> /dev/null

# samba-dev
apk add --no-cache rabbitmq-c-dev libevent-dev gpgme-dev imagemagick-dev zlib-dev libmemcached-dev librdkafka-dev libssh2-dev linux-headers yaml-dev #> /dev/null

if [[ -f /usr/bin/phar ]]; then
    rm -fr /usr/bin/phar
    mv /usr/bin/phar.phar /usr/bin/phar
    mv /usr/bin/php5 /usr/bin/php
    mv /usr/bin/php-cgi5 /usr/bin/php-cgi
    mv /usr/bin/phpize5 /usr/bin/phpize
    # mv /usr/bin/phpdbg5 /usr/bin/phpdbg
    mv /usr/bin/php-fpm5 /usr/bin/php-fpm
    mv /usr/bin/php-config5 /usr/bin/php-config
fi

if [[ ! -f '/usr/bin/composer' ]]; then
    wget -cq https://mirrors.cloud.tencent.com/composer/composer.phar -O /usr/bin/composer
    chmod +x /usr/bin/composer
    # composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer
fi

# TODO
# zookeeper leveldb alpine 3.7 no library
# memcache event crypto unknown error
# smbclient 抛弃
exts='amqp ev gnupg hprose igbinary imagick msgpack memcached mongodb protobuf rar rdkafka redis scrypt stomp ssh2 yac yaf swoole xhprof xdebug yaml zstd'
ext_dir=$(php-config --extension-dir)
mkdir -p /tmp/.build/exts && cd /tmp/.build
for ext in ${exts}
do
    uext=$(echo $ext | tr 'a-z' 'A-Z')
    ext_ver=$(eval echo \$"PHP_EXT_${uext}_VER")
    file_url="${ext_url}/${ext}/${ext}-${ext_ver}.tgz"
    if [ ! -f "${ext_dir}/${ext}.so" ]; then
        if [[ ! -f  "/tmp/.build/exts/${ext}-${ext_ver}.tgz" ]]; then
            cd /tmp/.build/exts/ && wget -cq $file_url
            rm -fr ${ext}-${ext_ver}
            tar -xvf ${ext}-${ext_ver}.tgz > /dev/null 2>&1
        fi

        if [[ "${ext}" == 'xhprof' ]]; then
            cd "/tmp/.build/exts/${ext}-${ext_ver}/extension"
        else
            cd "/tmp/.build/exts/${ext}-${ext_ver}"
        fi
        phpize && ./configure && make -j${CORES} && make install

        if [[ ! -f "${ext_dir}/${ext}.so" ]]; then
            echo "$ext install fail"
            exit 1
        else
            if [[ "$ext" == 'opcache' ]] || [[ "$ext" == 'xdebug' ]]; then
                echo "zend_extension=${ext}.so" > /etc/php5/conf.d/${ext}.ini
            else
                if [[ "$ext" == 'ev' ]]; then
                    echo "extension=${ext}.so" > /etc/php5/conf.d/zz-${ext}.ini
                else
                    echo "extension=${ext}.so" > /etc/php5/conf.d/${ext}.ini
                fi
            fi
        fi
    else
        echo "$ext has compiled"
    fi
done

ioncube_path="/tmp/.build/exts/ioncube"
ioncube_file="ioncube_loader_lin_5.6.so"

if [[ ! -f "${ext_dir}/ioncube.so" ]]; then
    echo '==>ioncube installing'
    cd /tmp/.build/exts
    if [[ ! -d "$ioncube_path" ]]; then
        wget -cq "${ext_url}/ioncube/ioncube_loaders_lin_x86-64.tar.gz"
        tar -xvf ioncube_loaders_lin_x86-64.tar.gz > /dev/null
    fi

    if [[ -f "${ioncube_path}/$ioncube_file" ]]; then
        cp "${ioncube_path}/$ioncube_file" "${ext_dir}/ioncube.so"
        echo "zend_extension=ioncube.so" > /etc/php5/conf.d/ioncube.ini
    else
        echo "php version ${ver} is not supported"
    fi
else
    echo 'ioncube already installed'
fi

if [[ ! -f "${ext_dir}/sourceguardian.so" ]]; then
    echo '==>SourceGuardian 12 installing'
    cd /tmp/.build/exts
    if [[ ! -d "/tmp/.build/exts/sourceguardian" ]]; then
        mkdir -p /tmp/.build/exts/sourceguardian
        wget -cq "${ext_url}/sourceguardian/loaders.linux-x86_64.tar.gz"
        cd /tmp/.build/exts/sourceguardian
        tar -xvf ../loaders.linux-x86_64.tar.gz > /dev/null
    fi

    if [[ -f "/tmp/.build/exts/sourceguardian/ixed.${php_two_bit_ver}.lin" ]]; then
        cp "/tmp/.build/exts/sourceguardian/ixed.${php_two_bit_ver}.lin" "${ext_dir}/sourceguardian.so"
        echo "extension=sourceguardian.so" >> ${ini_file}
    else
        echo "php version ${ver} is not supported"
    fi
else
    echo 'sourceguardian already installed'
fi

apk del .deps > /dev/null
