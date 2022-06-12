#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-11-13 20:44:45
 # @LastEditTime: 2022-06-12 18:40:18
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/php/81/build.sh
###

CORES=$(grep -c '^processor' /proc/cpuinfo)
ARCH=$(uname -m)

ext_url='https://mirrors.xieke.org/Src/php-exts'

# apk search php81 | grep -v -E 'dbg|dev|apache|embed|couchbase|cgi' | grep -v '\-doc\-' | sort | awk -F '\-[0-9]\.[0-9]' '{print $1}' | tr "\n" ' '
# ext couchbase: file libcouchbase_php_core.so exist but can't find
if [[ -z "$(command -v composer)" ]]; then
    apk add --no-cache php81 php81-bcmath php81-brotli php81-bz2 php81-calendar php81-common php81-ctype php81-curl php81-dba php81-dom php81-enchant php81-exif php81-ffi php81-fileinfo php81-fpm php81-ftp php81-gd php81-gettext php81-gmp php81-iconv php81-imap php81-intl php81-ldap php81-litespeed php81-mbstring php81-mysqli php81-mysqlnd php81-odbc php81-opcache php81-openssl php81-pcntl php81-pdo php81-pdo_dblib php81-pdo_mysql php81-pdo_odbc php81-pdo_pgsql php81-pdo_sqlite php81-pecl-amqp php81-pecl-apcu php81-pecl-ast php81-pecl-event php81-pecl-igbinary php81-pecl-imagick php81-pecl-lzf php81-pecl-mailparse php81-pecl-maxminddb php81-pecl-memcache php81-pecl-memcached php81-pecl-mongodb php81-pecl-msgpack php81-pecl-protobuf php81-pecl-psr php81-pecl-rdkafka php81-pecl-redis php81-pecl-ssh2 php81-pecl-swoole php81-pecl-uploadprogress php81-pecl-uuid php81-pecl-vips php81-pecl-xdebug php81-pecl-xhprof php81-pecl-xhprof-assets php81-pecl-yaml php81-pecl-zstd php81-pgsql php81-phar php81-posix php81-pspell php81-session php81-shmop php81-simplexml php81-snmp php81-soap php81-sockets php81-sodium php81-sqlite3 php81-sysvmsg php81-sysvsem php81-sysvshm php81-tidy php81-tokenizer php81-xml php81-xmlreader php81-xmlwriter php81-xsl php81-zip
fi

# composer config -g repos.packagist composer https://mirrors.cloud.tencent.com/composer

# 重命名可执行文件 方便操作而不用多余的加版本号
if [[ -f /usr/bin/php81 ]]; then
    cd /usr/bin
    rm -fr phar81
    mv phar.phar81 phar
    mv php81 php
    # mv php-cgi81 php-cgi
    # mv pear81 pear
    # mv pecl81 pecl
    # php-dev
    # mv php-config81 php-config
    # mv phpdbg81 phpdbg
    # mv phpize81 phpize
    mv /usr/sbin/php-fpm81 /usr/sbin/php-fpm
fi

# 安装最新版本 Composer
if [[ -z "$(command -v composer)" ]]; then
    wget -cq --no-check-certificate https://mirrors.aliyun.com/composer/composer.phar -O /usr/bin/composer
    chmod +x /usr/bin/composer
fi

ext_dir=$(php-config --extension-dir)
ini_dir=$(php-config --ini-dir)
ini_file=$(php --ini | grep '^Loaded Configuration File' | awk -F ' ' '{print $4}')
# gnupg gpgme-dev depency qtbase fuck

# alpine included: event xhprof xdebug ssh2 protobuf imagick igbinary msgpack memcache memcached mongodb redis yaml
# 不兼容 8 scrypt stomp hprose
# amqp rdkafka swoole zstd
# leveldb not maintained
# exts="ev rar yac yaf"

mkdir -p /tmp/.build/exts && cd /tmp/.build
# for ext in ${exts}
# do
#     uext=$(echo $ext | tr 'a-z' 'A-Z')
#     ext_ver=$(eval echo \$"PHP_EXT_${uext}_VER")
#     file_url="${ext_url}/${ext}/${ext}-${ext_ver}.tgz"
#     if [ ! -f "${ext_dir}/${ext}.so" ]; then
#         if [[ ! -f  "/tmp/.build/exts/${ext}-${ext_ver}.tgz" ]]; then
#             cd /tmp/.build/exts/ && wget -cq $file_url
#             rm -fr ${ext}-${ext_ver}
#             tar -xvf ${ext}-${ext_ver}.tgz > /dev/null 2>&1
#         fi

#         if [[ "${ext}" == 'xhprof' ]]; then
#             cd "/tmp/.build/exts/${ext}-${ext_ver}/extension"
#         else
#             cd "/tmp/.build/exts/${ext}-${ext_ver}"
#         fi
#         phpize && ./configure && make -j${CORES} && make install

#         if [[ ! -f "${ext_dir}/${ext}.so" ]]; then
#             echo "$ext install fail"
#             exit 1
#         else
#             if [[ "$ext" == 'opcache' ]] || [[ "$ext" == 'xdebug' ]]; then
#                 echo "zend_extension=${ext}.so" > ${ini_dir}/${ext}.ini
#             else
#                 if [[ "$ext" == 'ev' ]]; then
#                     echo "extension=${ext}.so" > ${ini_dir}/zz-${ext}.ini
#                 else
#                     echo "extension=${ext}.so" > ${ini_dir}/${ext}.ini
#                 fi
#             fi
#         fi
#     else
#         echo "$ext has compiled"
#     fi
# done

# php_two_bit_ver=$(php-config  --version | awk -F '.' '{print $1"."$2}')
php_two_bit_ver=$(php -v | head -n 1 | awk -F ' ' '{print $2}' | awk -F '.' '{print $1"."$2}')
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

# if [[ ! -f "${ext_dir}/sourceguardian.so" ]]; then
#     echo '==>SourceGuardian 12 installing'
#     cd /tmp/.build/exts
#     if [[ ! -d "/tmp/.build/exts/sourceguardian" ]]; then
#         mkdir -p /tmp/.build/exts/sourceguardian
#         wget -cq "${ext_url}/sourceguardian/loaders.linux-x86_64.tar.gz"
#         cd /tmp/.build/exts/sourceguardian
#         tar -xvf ../loaders.linux-x86_64.tar.gz > /dev/null
#     fi

#     if [[ -f "/tmp/.build/exts/sourceguardian/ixed.${php_two_bit_ver}.lin" ]]; then
#         cp "/tmp/.build/exts/sourceguardian/ixed.${php_two_bit_ver}.lin" "${ext_dir}/sourceguardian.so"
#         echo "extension=sourceguardian.so" >> ${ini_file}
#     else
#         echo "php version ${ver} is not supported"
#     fi
# else
#     echo 'sourceguardian already installed'
# fi
rm -fr /tmp/.build
