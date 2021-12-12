#!/usr/bin/env sh
###
 # @Author: Cloudflying
 # @Date: 2021-11-13 19:13:52
 # @LastEditTime: 2021-11-14 12:56:09
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/php/74/build.sh
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

# php7-dbg php7-phpdbg
if [[ -z "$(command -v composer)" ]]; then
    apk add --no-cache php7 php7-bcmath php7-brotli php7-bz2 php7-calendar php7-ctype php7-curl php7-dba php7-dev php7-dom \
		php7-embed php7-enchant php7-exif php7-fileinfo php7-fpm php7-ftp php7-gd php7-gettext php7-gmp php7-iconv php7-imap php7-intl \
		php7-json php7-ldap php7-mbstring php7-mysqli php7-mysqlnd php7-odbc php7-openssl php7-pcntl php7-pdo php7-pdo_dblib \
		php7-pdo_mysql php7-pdo_odbc php7-pdo_pgsql php7-pdo_sqlite php7-pear php7-pecl-amqp php7-pecl-event php7-pecl-imagick \
		php7-pecl-imagick-dev php7-pecl-maxminddb  php7-pecl-mcrypt php7-pecl-memcache php7-pecl-memcached php7-pecl-mongodb \
		php7-pecl-msgpack php7-pecl-protobuf php7-pecl-psr php7-pecl-redis php7-pecl-yaml php7-pecl-zmq php7-pgsql php7-phar \
		php7-posix php7-pspell php7-session php7-shmop php7-simplexml php7-snmp php7-soap php7-sockets php7-sodium php7-sqlite3 \
		php7-static php7-sysvmsg php7-sysvsem php7-sysvshm php7-tidy php7-tokenizer php7-xml php7-xmlreader php7-xmlrpc php7-cgi\
		php7-ffi php7-opcache php7-pecl-apcu php7-pecl-lzf  php7-xmlwriter php7-xsl php7-zip \
        php7-pecl-ssh2 php7-pecl-vips php7-pecl-xdebug php7-pecl-xhprof php7-phalcon
fi

# composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer
# gpgme-dev
# libevent-dev dep python3
# alpine included: rabbitmq-c-dev libevent-dev imagemagick-dev yaml-dev libmemcached-dev libssh2-dev
if [[ ! -f "/usr/include/amqp.h" ]]; then
    apk add --no-cache zlib-dev  librdkafka-dev linux-headers leveldb-dev #> /dev/null
fi

# 重命名可执行文件 方便操作而不用多余的加版本号
if [[ -f /usr/bin/phar.phar ]]; then
    cd /usr/bin
    rm -fr phar phar7  phar.phar phar.phar7 php php-cgi php-config phpdbg phpize
    mv phar7.phar phar
    mv php7 php
    mv php-cgi7 php-cgi
    mv php-config7 php-config
    mv phpdbg7 phpdbg
    mv phpize7 phpize
    mv /usr/sbin/php-fpm7 /usr/sbin/php-fpm
fi

# 安装最新版本 Composer
if [[ -z "$(command -v composer)" ]]; then
    wget -c --no-check-certificate https://mirrors.aliyun.com/composer/composer.phar -O /usr/bin/composer
    chmod +x /usr/bin/composer
fi

ext_dir=$(php-config --extension-dir)
ini_dir=$(php-config --ini-dir)
ini_file=$(php --ini | grep '^Loaded Configuration File' | awk -F ' ' '{print $4}')
# gnupg gpgme-dev depency qtbase fuck
# alpine included: amqp xdebug yaml xhprof igbinary imagick event protobuf msgpack redis memcache memcached mongodb ssh2
exts="ev hprose rar rdkafka scrypt stomp yac yaf swoole zstd leveldb"

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
