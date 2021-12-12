#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-11-13 20:44:45
 # @LastEditTime: 2021-11-14 13:04:35
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/php/80/build.sh
###

CORES=$(grep -c '^processor' /proc/cpuinfo)
ARCH=$(uname -m)

ext_url='https://hk.mirrors.xieke.org/Src/php-exts'

PHP_EXT_AMQP_VER=1.11.0RC1
PHP_EXT_EV_VER=1.1.5
PHP_EXT_CRYPTO_VER=0.3.2
PHP_EXT_EVENT_VER=3.0.7RC1
PHP_EXT_GEOIP_VER=1.1.1
PHP_EXT_GMAGICK_VER=2.0.6RC1
PHP_EXT_GNUPG_VER=1.5.0
PHP_EXT_GRPC_VER=1.42.0RC1
PHP_EXT_HPROSE_VER=1.8.0
PHP_EXT_IGBINARY_VER=3.2.6
PHP_EXT_IMAGICK_VER=3.6.0RC1
PHP_EXT_LEVELDB_VER=0.3.0
PHP_EXT_LIBSODIUM_VER=2.0.23
PHP_EXT_MCRYPT_VER=1.0.4
PHP_EXT_MEMCACHE_VER=8.0
PHP_EXT_MEMCACHED_VER=3.1.5
PHP_EXT_MONGODB_VER=1.11.1
PHP_EXT_MSGPACK_VER=2.2.0RC1
PHP_EXT_PDO_SQLSRV_VER=5.10.0beta1
PHP_EXT_PHALCON_VER=5.0.0alpha6
PHP_EXT_PKCS11_VER=1.0
PHP_EXT_PROTOBUF_VER=3.19.1
PHP_EXT_RAR_VER=4.2.0
PHP_EXT_REDIS_VER=5.3.4
PHP_EXT_RDKAFKA_VER=5.0.0
PHP_EXT_TENSOR_VER=3.0.00
PHP_EXT_SCRYPT_VER=1.4.2
PHP_EXT_STOMP_VER=2.0.2
PHP_EXT_SIMPLE_KAFKA_CLIENT_VER=0.1.4
PHP_EXT_SMBCLIENT_VER=1.0.6
PHP_EXT_SQLSRV_VER=5.10.0beta1
PHP_EXT_SSH2_VER=1.3.1
PHP_EXT_SWOOLE_VER=4.8.1
PHP_EXT_YAC_VER=2.3.0
PHP_EXT_YAF_VER=3.3.3
PHP_EXT_YACONF_VER=1.1.0
PHP_EXT_XHPROF_VER=2.3.5
PHP_EXT_XDEBUG_VER=3.1.1
PHP_EXT_YAML_VER=2.2.2
PHP_EXT_ZIP_VER=1.20.0
PHP_EXT_ZOOKEEPER_VER=1.0.0
PHP_EXT_ZSTD_VER=0.11.0

if [[ -z "$(command -v make)" ]]; then
    apk add --no-cache --virtual .deps wget curl autoconf make gcc g++ file #> /dev/null
fi

# php-dbg php-phpdbg
if [[ -z "$(command -v composer)" ]]; then
    apk add --no-cache php8 php8-bcmath php8-brotli php8-bz2 php8-calendar php8-ctype php8-curl php8-dba php8-dev php8-dom \
		php8-embed php8-enchant php8-exif php8-fileinfo php8-fpm php8-ftp php8-gd php8-gettext php8-gmp php8-iconv php8-imap php8-intl \
		php8-ldap php8-mbstring php8-mysqli php8-mysqlnd php8-odbc php8-openssl php8-pcntl php8-pdo php8-pdo_dblib php8-pdo_mysql \
		php8-pdo_odbc php8-pdo_pgsql php8-pdo_sqlite php8-pear php8-pecl-event php8-pecl-imagick php8-pecl-imagick-dev \
		php8-pecl-maxminddb php8-pecl-mcrypt php8-pecl-memcache php8-pecl-memcached php8-pecl-mongodb php8-pecl-msgpack php8-pecl-redis \
		php8-pecl-yaml php8-pgsql php8-phar php8-posix php8-pspell php8-session php8-shmop php8-simplexml php8-snmp \
		php8-soap php8-sockets php8-sodium php8-sqlite3 php8-sysvmsg php8-sysvsem php8-sysvshm php8-tidy php8-tokenizer php8-xml \
		php8-xmlreader php8-xmlwriter php8-xsl php8-zip php8-cgi php8-ffi php8-opcache php8-pecl-apcu php8-pecl-lzf php8-pecl-protobuf \
        php8-pecl-ssh2 php8-pecl-vips php8-pecl-xdebug php8-pecl-xhprof
fi

# composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer
# gpgme-dev
# libevent-dev dep python3
# alpine included: imagemagick-dev rabbitmq-c-dev libevent-dev yaml-dev libssh2-dev libmemcached-dev
if [[ ! -f "/usr/include/amqp.h" ]]; then
    apk add --no-cache rabbitmq-c-dev zlib-dev librdkafka-dev linux-headers leveldb-dev #> /dev/null
fi

# 重命名可执行文件 方便操作而不用多余的加版本号
if [[ -f /usr/bin/phar8 ]]; then
    cd /usr/bin
    rm -fr phar8
    mv phar.phar8 phar
    mv php8 php
    mv php-cgi8 php-cgi
    mv php-config8 php-config
    # mv phpdbg8 phpdbg
    mv phpize8 phpize
    mv /usr/sbin/php-fpm8 /usr/sbin/php-fpm
fi

ls -lha /usr/bin | grep php

# 安装最新版本 Composer
if [[ -z "$(command -v composer)" ]]; then
    wget -cq --no-check-certificate https://mirrors.aliyun.com/composer/composer.phar -O /usr/bin/composer
    chmod +x /usr/bin/composer
fi

ext_dir=$(php-config --extension-dir)
ini_dir=$(php-config --ini-dir)
ini_file=$(php --ini | grep '^Loaded Configuration File' | awk -F ' ' '{print $4}')
# gnupg gpgme-dev depency qtbase fuck
#
# alpine included: event xhprof xdebug ssh2 protobuf imagick igbinary msgpack memcache memcached mongodb redis yaml
# 不兼容 8 scrypt stomp hprose
exts="amqp ev rar rdkafka  yac yaf swoole zstd leveldb"

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
                echo "zend_extension=${ext}.so" > ${ini_dir}/${ext}.ini
            else
                if [[ "$ext" == 'ev' ]]; then
                    echo "extension=${ext}.so" > ${ini_dir}/zz-${ext}.ini
                else
                    echo "extension=${ext}.so" > ${ini_dir}/${ext}.ini
                fi
            fi
        fi
    else
        echo "$ext has compiled"
    fi
done

php_two_bit_ver=$(php-config  --version | awk -F '.' '{print $1"."$2}')
ioncube_path="/tmp/.build/exts/ioncube"
ioncube_file="ioncube_loader_lin_${php_two_bit_ver}.so"

if [[ ! -f "${ext_dir}/ioncube.so" ]]; then
    echo '==>ioncube installing'
    cd /tmp/.build/exts
    if [[ ! -d "$ioncube_path" ]]; then
        wget -cq "${ext_url}/ioncube/ioncube_loaders_lin_x86-64.tar.gz"
        tar -xvf ioncube_loaders_lin_x86-64.tar.gz > /dev/null
    fi

    if [[ -f "${ioncube_path}/$ioncube_file" ]]; then
        cp "${ioncube_path}/$ioncube_file" "${ext_dir}/ioncube.so"
        # echo "zend_extension=ioncube.so" > ${ini_dir}/ioncube.ini
        echo "zend_extension=ioncube.so" >> ${ini_file}
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
