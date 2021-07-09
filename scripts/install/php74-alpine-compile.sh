#!/usr/bin/env sh
cd /data/build/php-7.4.13
# https://github.com/docker-library/php/issues/272
# -D_LARGEFILE_SOURCE and -D_FILE_OFFSET_BITS=64 (https://www.php.net/manual/en/intro.filesystem.php)
PHP_CFLAGS="-fstack-protector-strong -fpic -fpie -O2 -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64"
PHP_CPPFLAGS="$PHP_CFLAGS"
PHP_LDFLAGS="-Wl,-O1 -pie"

export CFLAGS="$PHP_CFLAGS" \
		CPPFLAGS="$PHP_CPPFLAGS" \
		LDFLAGS="$PHP_LDFLAGS" \

sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories

# Depends
if [[ -z "$(command -v make )" ]]; then
    apk update
    apk add --no-cache --virtual .build-deps \
            autoconf \
            alpine-sdk \
            argon2-dev \
            coreutils \
            curl-dev \
            libedit-dev \
            libevent-dev \
            libsodium-dev \
            libxml2-dev \
            linux-headers \
            oniguruma-dev \
            openssl-dev \
            sqlite-dev \
            autoconf \
            dpkg-dev \
            dpkg \
            file \
            g++ \
            gcc \
            libc-dev \
            make \
            pkgconf \
            re2c \
            bzip2-dev \
            libpng-dev \
            gmp-dev \
            aspell-dev \
            tidyhtml-dev \
            libxslt-dev \
            libzip-dev
fi

if [[ -z "$(command -v curl )" ]]; then
    apk add --no-cache \
            ca-certificates \
            curl \
            tar \
            xz \
            openssl
fi

if [[ -z "$(grep '^www:' /etc/passwd)" ]]; then
    addgroup -g 318 -S www
    adduser -u 318 -D -S -G www www
fi

ARCH="$(dpkg-architecture --query DEB_BUILD_GNU_TYPE)"
mkdir -p /etc/php/conf.d

make -j "$(nproc)"
exit
./configure \
    --build="${ARCH}" \
    --with-config-file-path="/etc/php" \
    --with-config-file-scan-dir="/etc/php/conf.d" \
    --enable-option-checking=fatal \
    --enable-bcmath \
    --enable-calendar \
    --enable-dba \
    --enable-exif \
    --enable-ftp \
    --with-gettext \
    --enable-gd \
    --with-gmp \
    --with-iconv \
    --with-imap \
    --enable-intl \
    --enable-json \
    --with-ldap \
    --with-libxml \
    --enable-mbstring \
    --with-mysqli \
    --enable-mysqlnd \
    --enable-opcache \
    --enable-pcntl \
    --with-pspell \
    --enable-shmop \
    --enable-simplexml \
    --with-snmp \
    --enable-soap \
    --enable-sockets \
    --enable-sysvmsg \
    --with-tidy \
    --enable-tokenizer \
    --with-xmlrpc \
    --with-xsl \
    --with-zip \
    --with-bz2 \
    --with-pic \
	--with-curl \
    --with-password-argon2 \
    --with-mhash \
	--with-pdo-sqlite=/usr \
	--with-libedit \
    --with-sodium=shared \
	--with-sqlite3=/usr \
	--with-openssl \
	--with-zlib
