#!/usr/bin/env bash

docker run -d \
		  --name mariadb \
		  -v /Volumes/Data/Volumes/mariadb:/var/lib/mysql \
          -p 3306:3306 \
          -e MYSQL_ROOT_PASSWORD=19960318 \
          mariadb:10.3.8 \
          --character-set-server=utf8mb4 \
          --collation-server=utf8mb4_unicode_ci
