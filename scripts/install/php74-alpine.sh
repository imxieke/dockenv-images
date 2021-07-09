#!/usr/bin/env sh

sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# https://cloudflying.coding.net/p/storage/d/mirrors/git/raw/master/php_exts/ioncube/ioncube_loader_lin_5.6.so
# https://cloudflying.coding.net/p/storage/d/mirrors/git/raw/master/php_exts/rar/rar-4.2.0.tgz
PKGS_MIRRORS_URL="https://cloudflying.coding.net/p/storage/d/mirrors/git/raw/master"
PHP_INI_FILE=$(php --ini | grep 'Loaded Configuration File' | awk -F ' ' '{print $4}')
PHP_EXTENSION_CONF_DIR=$(php --ini | grep 'Scan for additional .ini files in' | awk -F ' ' '{print $7}')
PHP_EXTENSION_SO_DIR=$(php-config --extension-dir)

PHP_VERSION=7.4.13
EXTENSION_APCU_VERSION=5.1.19
EXTENSION_EV_VERSION=1.0.9
EXTENSION_MEMCACHE_VERSION=8.0
EXTENSION_MEMCACHED_VERSION=3.1.5
EXTENSION_MONGODB_VERSION=1.9.0
EXTENSION_REDIS_VERSION=5.3.2
EXTENSION_SWOOLE_VERSION=4.5.9
EXTENSION_MSGPACK_VERSION=2.1.2
EXTENSION_RAR_VERSION=4.2.0
EXTENSION_EVENT_VERSION=3.0.2
EXTENSION_IMAGICK_VERSION=3.4.4

# exit
strtoupper()
{
    echo $1 | tr '[a-z]' '[A-Z]'
}

# from pecl query extension
install_extension()
{
    mkdir -p /tmp/build
    cd /tmp/build

    NAME=$1
    if [[ -z ${NAME} ]]; then
        echo "extension name param empty"
        # exit 1
    fi

    if [[ "${NAME}" == 'event' || "${NAME}" == 'ev' ]]; then
        if [[ -f "${PHP_EXTENSION_CONF_DIR}/z-${NAME}.ini" ]]; then
            echo "extension ${NAME} Installed in : ${PHP_EXTENSION_CONF_DIR}/z-${NAME}.ini "
            return 0
        fi
    else
        if [[ -f "${PHP_EXTENSION_CONF_DIR}/${NAME}.ini" ]]; then
            echo "extension ${NAME} Installed in : ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini"
            return 0
        fi
    fi

    KEY="EXTENSION_"$(strtoupper $1)"_VERSION"
    VERSION=$(eval echo '$'${KEY})
    # URL="https://pecl.php.net/get/${NAME}-${VERSION}.tgz"
    URL="${PKGS_MIRRORS_URL}/php_exts/${NAME}/${NAME}-${VERSION}.tgz"

    if [[ ! -f "${NAME}-${VERSION}.tgz" ]]; then
        wget -O ${NAME}-${VERSION}.tgz ${URL}
    fi

    if [[ ! -d "${NAME}-${VERSION}" ]]; then
        tar -xvf ${NAME}-${VERSION}.tgz
    fi

    cd ${NAME}-${VERSION}
    phpize && ./configure && make -j "$(nproc)" && make install

    if [[ "${NAME}" == 'event' || "${NAME}" == 'ev' ]]; then
        echo "extension=${NAME}.so" > ${PHP_EXTENSION_CONF_DIR}/z-${NAME}.ini
    elif [[ "${NAME}" == 'opcache' ]]; then
        echo "zend_extension=${NAME}.so" > ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    else
        echo "extension=${NAME}.so" > ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    fi
}

install_extension_from_src()
{
    mkdir -p /tmp/build
    if [[ ! -d "/tmp/build/php-${PHP_VERSION}" ]]; then
        wget ${PKGS_MIRRORS_URL}/src/php/php-${PHP_VERSION}.tar.xz
        tar -xvf php-${PHP_VERSION}.tar.xz
    fi

    cd /tmp/build/php-${PHP_VERSION}

    NAME=$1
    if [[ -z ${NAME} ]]; then
        echo "extension name param empty"
        # exit 1
    fi

    if [[ "${NAME}" == 'event' || "${NAME}" == 'ev' ]]; then
        if [[ -f "${PHP_EXTENSION_CONF_DIR}/z-${NAME}.ini" ]]; then
            echo "extension ${NAME} Installed in : ${PHP_EXTENSION_CONF_DIR}/z-${NAME}.ini "
            return 0
        fi
    else
        if [[ -f "${PHP_EXTENSION_CONF_DIR}/${NAME}.ini" ]]; then
            echo "extension ${NAME} Installed in : ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini"
            return 0
        fi
    fi

    cd ext/${NAME}

    phpize && ./configure && make -j "$(nproc)" && make install

    if [[ ! -f "${PHP_EXTENSION_SO_DIR}/${NAME}.so" ]]; then
        echo "Compile fail ${PHP_EXTENSION_SO_DIR}/${NAME}.so Not Found"
        exit 1
    fi

    if [[ "${NAME}" == 'event' || "${NAME}" == 'ev' ]]; then
        echo "extension=${NAME}.so" > ${PHP_EXTENSION_CONF_DIR}/z-${NAME}.ini
    elif [[ "${NAME}" == 'opcache' ]]; then
        echo ";zend_extension=${NAME}.so" > ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    else
        echo "extension=${NAME}.so" > ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    fi
}

# disable PHP extension
disable_extension()
{
    NAME=$1
    if [[ -z ${NAME} ]]; then
        echo "extension name param empty"
        exit 1
    fi

    FILE_PATH=${PHP_EXTENSION_CONF_DIR}/${NAME}.ini

    if [[ -f ${FILE_PATH} ]]; then
        sed -i 's/zend/;zend/g' ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
        sed -i 's/ext/;ext/g'   ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    else
        echo ${NAME} " extension Not Found"
    fi
}

# enable PHP extension
enable_extension()
{
    NAME=$1
    if [[ -z ${NAME} ]]; then
        echo "extension name param empty"
        exit 1
    fi

    FILE_PATH=${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    if [[ -f ${FILE_PATH} ]]; then
        sed -i 's/;zend/zend/g' ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
        sed -i 's/;ext/ext/g'   ${PHP_EXTENSION_CONF_DIR}/${NAME}.ini
    else
        echo ${NAME} " extension Not Found"
    fi
}

install_ioncube()
{
    if [[ ! -f "${PHP_EXTENSION_CONF_DIR}/ioncube.ini" ]]; then
        wget ${PKGS_MIRRORS_URL}/"php_exts/ioncube/ioncube_loader_lin_7.4.so" -O ${PHP_EXTENSION_SO_DIR}/ioncube.so
        echo "zend_extension=ioncube.so" > ${PHP_EXTENSION_CONF_DIR}/ioncube.ini
    fi
}

# depend
if [[ -z $(command -v make)  ]]; then
    apk update
    apk add --no-cache --virtual .build-deps \
        alpine-sdk \
        autoconf \
        libevent \
        libevent-dev \
        zlib-dev \
        libsodium-dev \
        imagemagick-dev \
        libmemcached-dev \
        openssl-dev \
        zlib-dev \
        msgpack-c-dev \
        libxml2-dev \
        libzip-dev \
        bzip2-dev \
        libpng-dev \
        gmp-dev \
        gettext-dev \
        imap-dev \
        icu-dev \
        freetds-dev \
        readline-dev \
        aspell-dev \
        net-snmp-dev \
        tidyhtml-dev
fi

# runtime depend libsodium-dev imagemagick-dev libmemcached-dev
if [[ -z $(command -v php)  ]]; then
    apk add --no-cache
fi

install_extension apcu
install_extension ev
install_extension imagick
install_extension memcache
install_extension memcached
install_extension mongodb
install_extension msgpack
install_extension redis
install_extension rar
install_extension swoole
install_ioncube

install_extension_from_src bcmath
install_extension_from_src bz2
install_extension_from_src calendar
install_extension_from_src dba
# install_extension_from_src enchant
install_extension_from_src exif
install_extension_from_src gd
install_extension_from_src gettext
install_extension_from_src gmp
install_extension_from_src imap
install_extension_from_src intl
# install_extension_from_src ldap
install_extension_from_src mysqli
# install_extension_from_src odbc
install_extension_from_src opcache
install_extension_from_src pcntl
install_extension_from_src pdo_dblib
# install_extension_from_src pdo_pgsql
# install_extension_from_src pgsql
install_extension_from_src pspell
install_extension_from_src shmop
install_extension_from_src snmp
install_extension_from_src sockets
install_extension_from_src sysvmsg
install_extension_from_src sysvsem
install_extension_from_src sysvshm
install_extension_from_src tidy
install_extension_from_src xmlrpc
install_extension_from_src zip
disable_extension opcache
disable_extension apcu

chmod -R 755 ${PHP_EXTENSION_SO_DIR}

# Modify php.ini
sed -i 's/;date.timezone =/date.timezone\ =\ ASia\/Shanghai/g' ${PHP_INI_FILE}
sed -i 's/expose_php\ =\ On/expose_php\ =\ Off/g' ${PHP_EXTENSION_CONF_DIR}
sed -i 's/max_execution_time\ =\ 30/max_execution_time\ =\ 10/g' ${PHP_EXTENSION_CONF_DIR}
sed -i 's/max_file_uploads\ =\ 20/max_file_uploads\ =\ 50/g' ${PHP_EXTENSION_CONF_DIR}
sed -i 's/display_errors\ =\ Off/display_errors\ =\ On/g' ${PHP_EXTENSION_CONF_DIR}

apk del .build-deps
