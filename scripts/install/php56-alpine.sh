#!/usr/bin/env sh
# alpien 3.8 3.8 以上 不支持 php 5
# php 5 v5.6.40-r0

sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# https://cloudflying.coding.net/p/storage/d/mirrors/git/raw/master/php_exts/ioncube/ioncube_loader_lin_5.6.so
# https://cloudflying.coding.net/p/storage/d/mirrors/git/raw/master/php_exts/rar/rar-4.2.0.tgz
PKGS_MIRRORS_URL="https://cloudflying.coding.net/p/storage/d/mirrors/git/raw/master/php_exts"
CORES=$(grep -c 'processor' /proc/cpuinfo)
MAKE_CORES=$(expr ${CORES} \* 2)

EXTENSION_EV_VERSION=1.0.9
EXTENSION_MEMCACHE_VERSION=2.2.7
EXTENSION_MEMCACHED_VERSION=2.2.0
EXTENSION_MONGODB_VERSION=1.7.5
EXTENSION_REDIS_VERSION=5.3.2
EXTENSION_SWOOLE_VERSION=1.10.5
EXTENSION_MSGPACK_VERSION=0.5.7
EXTENSION_LIBSODIUM_VERSION=1.0.7
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
        if [[ -f "/etc/php5/conf.d/z-${NAME}.ini" ]]; then
            break
        fi
    else
        if [[ -f "/etc/php5/conf.d/${NAME}.ini" ]]; then
            break
        fi
    fi

    KEY="EXTENSION_"$(strtoupper $1)"_VERSION"
    VERSION=$(eval echo '$'${KEY})
    # URL="https://pecl.php.net/get/${NAME}-${VERSION}.tgz"
    URL="${PKGS_MIRRORS_URL}/${NAME}/${NAME}-${VERSION}.tgz"

    if [[ -f "${NAME}-${VERSION}.tgz" ]]; then
        echo "${NAME}-${VERSION}.tgz exist"
    else
        # Coding Not Allow CURL
        # if [[ -z "$(curl -sI ${URL} | grep '200 OK')" ]]; then
            # echo "${NAME} extension Not Found"
            # echo $URL
            # exit
            # exit 1
        # fi
        wget -O ${NAME}-${VERSION}.tgz ${URL}
    fi

    if [[ ! -d "${NAME}-${VERSION}" ]]; then
        tar -xvf ${NAME}-${VERSION}.tgz
        cd ${NAME}-${VERSION}
        phpize
        ./configure
        make -j${MAKE_CORES}
        make install
        if [[ "${NAME}" == 'event' || "${NAME}" == 'ev' ]]; then
            echo "extension=${NAME}.so" > /etc/php5/conf.d/z-${NAME}.ini
        elif [[ "${NAME}" == 'opcache' ]]; then
            echo "zend_extension=${NAME}.so" > /etc/php5/conf.d/${NAME}.ini
        else
            echo "extension=${NAME}.so" > /etc/php5/conf.d/${NAME}.ini
        fi
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

    FILE_PATH=/etc/php5/conf.d/${NAME}.ini

    if [[ -f ${FILE_PATH} ]]; then
        sed -i 's/zend/;zend/g' /etc/php5/conf.d/${NAME}.ini
        sed -i 's/ext/;ext/g'   /etc/php5/conf.d/${NAME}.ini
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

    FILE_PATH=/etc/php5/conf.d/${NAME}.ini
    if [[ -f ${FILE_PATH} ]]; then
        sed -i 's/;zend/zend/g' /etc/php5/conf.d/${NAME}.ini
        sed -i 's/;ext/ext/g'   /etc/php5/conf.d/${NAME}.ini
    else
        echo ${NAME} " extension Not Found"
    fi
}

install_ioncube()
{
    if [[ ! -f "/etc/php5/conf.d/ioncube.ini" ]]; then
        wget ${PKGS_MIRRORS_URL}/"ioncube/ioncube_loader_lin_5.6.so" -O /usr/lib/php5/modules/ioncube.so
        echo "zend_extension=ioncube.so" > /etc/php5/conf.d/ioncube.ini
    fi
}

# depend
if [[ -z $(command -v make) ]]; then
    apk update
    apk add --no-cache --virtual .build-deps \
                    alpine-sdk \
                    autoconf \
                    libevent \
                    libevent-dev \
                    zlib-dev
fi


# runtime depend libsodium-dev imagemagick-dev libmemcached-dev
if [[ -z $(command -v php5)  ]]; then
    apk add --no-cache \
                   libsodium-dev \
                   imagemagick-dev \
                   libmemcached-dev \
                   php5-apcu \
                   php5-bcmath \
                   php5-bz2 \
                   php5-calendar \
                   php5-cli \
                   php5-cgi \
                   php5-common \
                   php5-ctype \
                   php5-curl \
                   php5-dba \
                   php5-dbg \
                   php5-dev \
                   php5-dom \
                   php5-embed \
                   php5-enchant \
                   php5-exif \
                   php5-fpm \
                   php5-ftp \
                   php5-gd \
                   php5-gettext \
                   php5-gmp \
                   php5-iconv \
                   php5-imap \
                   php5-intl \
                   php5-json \
                   php5-ldap \
                   php5-mcrypt \
                   php5-mssql \
                   php5-mysql \
                   php5-mysqli \
                   php5-odbc \
                   php5-opcache \
                   php5-openssl \
                   php5-pcntl \
                   php5-pdo \
                   php5-pdo_dblib \
                   php5-pdo_mysql \
                   php5-pdo_odbc \
                   php5-pdo_pgsql \
                   php5-pdo_sqlite \
                   php5-pgsql \
                   php5-phar \
                   php5-phpdbg \
                   php5-posix \
                   php5-pspell \
                   php5-shmop \
                   php5-snmp \
                   php5-soap \
                   php5-sockets \
                   php5-sqlite3 \
                   php5-suhosin \
                   php5-sysvmsg \
                   php5-sysvsem \
                   php5-sysvshm \
                   php5-wddx \
                   php5-xml \
                   php5-xmlreader \
                   php5-xmlrpc \
                   php5-xsl \
                   php5-zip

    # add link
    ln -s /usr/bin/php5 /usr/bin/php
    ln -s /usr/bin/php-cgi5 /usr/bin/php-cgi
    ln -s /usr/bin/php-config5 /usr/bin/php-config
    ln -s /usr/bin/php-fpm5 /usr/bin/php-fpm
    ln -s /usr/bin/phpdbg5 /usr/bin/phpdbg
    ln -s /usr/bin/phpize5 /usr/bin/phpize
fi

install_extension ev
install_extension rar
install_extension redis
install_extension swoole
install_extension memcache
install_extension memcached
install_extension mongodb
install_extension msgpack
install_extension libsodium
install_extension imagick
install_ioncube
disable_extension opcache
disable_extension apcu

chmod -R 755 /usr/lib/php5/modules/

# Modify php.ini
sed -i 's/UTC/ASia\/Shanghai/g' /etc/php5/php.ini
sed -i 's/expose_php\ =\ On/expose_php\ =\ Off/g' /etc/php5/php.ini
sed -i 's/max_execution_time\ =\ 30/max_execution_time\ =\ 10/g' /etc/php5/php.ini
sed -i 's/max_file_uploads\ =\ 20/max_file_uploads\ =\ 50/g' /etc/php5/php.ini
sed -i 's/display_errors\ =\ Off/display_errors\ =\ On/g' /etc/php5/php.ini
display_errors = Off
apk del .build-deps
