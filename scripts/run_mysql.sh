#!/usr/bin/env bash

MYSQL_PASSWORD=$(grep MYSQL_PASSWORD conf.ini | awk -F '=' '{print $2}')

docker run -d \
	-p 3306:3306 \
	-p 33060:33060 \
	--hostname=mysql \
	--name=mysql \
	-e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} \
	-v /Volumes/Data/Dev/mysql/docker:/var/lib/mysql \
	registry.cn-hongkong.aliyuncs.com/imxieke/mysql:latest \
	--character-set-server=utf8mb4 \
	--collation-server=utf8mb4_unicode_ci
