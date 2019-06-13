#!/bin/sh
# Description: Build php extensions.
# time : 27 Dec 2017

SWOOLE_VER="4.3.2"
RAR_VER="4.0.0"
REDIS_VER="3.1.5"
IONCUBE_VER="10.3.4"
IMAGICK_VER="3.4.3"
cur_dir="/tmp"

# PHP_VER=$(apk info php | grep descr | awk -F '-' '{print $2}')

PHP_FULLVER=$(php -v | head -n 1 | awk -F ' ' '{print $2}')
PHP_VER=${PHP_FULLVER:0:3}

build()
{
	phpize && ./configure && make -j8 && make install
}

imagick()
{
	name="imagick"
	cd ${cur_dir}
	wget https://pecl.php.net/get/${name}-${IMAGICK_VER}.tgz && tar -xvf ${name}-${IMAGICK_VER}.tgz
	cd ${name}-${IMAGICK_VER} && build
	echo "extension=${name}.so" > /etc/php7/conf.d/${name}.ini
}

swoole()
{
	name="swoole"
	cd ${cur_dir}
	wget https://dev.tencent.com/u/imxieke/p/attachment/git/raw/master/src/${name}-${SWOOLE_VER}.tgz && tar -xvf ${name}-${SWOOLE_VER}.tgz
	cd ${name}-${SWOOLE_VER}
	# have unknow error
	#if [ `cat /etc/os-release  | grep Alpine\ Linux` ]; then
		echo "Linux Aio Not Avaiable in Alpine Linux"
		sed -i 's/#define\ HAVE_LINUX_AIO/\/\/#define\ HAVE_LINUX_AIO/g' swoole_config.h
	#fi
	build
	echo "extension=${name}.so" > /etc/php7/conf.d/${name}.ini
}

rar(){
	name="rar"
	cd ${cur_dir}
	wget https://pecl.php.net/get/${name}-${RAR_VER}.tgz && tar -xvf ${name}-${RAR_VER}.tgz
	cd ${name}-${RAR_VER} && build
	echo "extension=${name}.so" > /etc/php7/conf.d/${name}.ini
}

redis()
{
	name="redis"
	cd ${cur_dir}
	wget https://pecl.php.net/get/${name}-${REDIS_VER}.tgz && tar -xvf ${name}-${REDIS_VER}.tgz
	cd ${name}-${REDIS_VER} && build
	echo "extension=${name}.so" > /etc/php7/conf.d/${name}.ini
}

ioncube()
{
	name="ioncube"
	cd ${cur_dir}
	wget https://dev.tencent.com/u/imxieke/p/attachment/git/raw/master/src/ioncube_loaders_lin_x86-64.zip -O ${name}.zip && unzip ${name}.zip
	mv ${name}/ioncube_loader_lin_${PHP_VER}.so /usr/lib/php7/modules/${name}.so
	# echo "extension=${name}.so" > /etc/php7/conf.d/${name}.ini
}

start()
{
	# imagick
	swoole
	rar
	# redis
	ioncube
	cd ${cur_dir}
	rm -fr *.tgz* *.zip* /tmp/*
}

start