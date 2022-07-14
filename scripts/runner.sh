#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2022-06-27 16:54:27
 # @LastEditTime: 2022-07-13 18:51:05
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/scripts/runner.sh
###

ROOT_PATH=$(dirname $(dirname $(realpath $0)))

CONF_PATH=${ROOT_PATH}/runtime/conf
DATA_PATH=${ROOT_PATH}/runtime/data
LOGS_PATH=${ROOT_PATH}/runtime/logs

run_boxs()
{
    docker run -d \
		--name boxs \
		--hostname boxs \
        -v ~/Code/Project/dockenv:/data \
        -e USER_PASSWD=boxs \
        -e IDE_PASSWD=boxs \
        -e SSH_PORT=22 \
		-p 8818:8818 \
		-p 10022:22 \
		-p 16080:6080 \
		-p 36800:6800 \
		-p 15555:15555 \
		ghcr.io/dockenv/boxs:latest
}

run_boxs_archlinux()
{
    docker run -d \
		--name archboxs \
		--hostname archboxs \
        --privileged \
        --tty \
        --interactive \
		-p 10022:22 \
		-p 10080:80 \
		-p 10443:443 \
		-p 15901:5901 \
		-p 16080:6080 \
		-p 16901:6901 \
		ghcr.io/dockenv/boxs:xfce-arch
}

run_xfce4()
{
    docker run -d \
		--name xfce4 \
		--hostname xfce4 \
        --privileged \
        --tty \
        --interactive \
		-p 20022:22 \
		-p 20080:80 \
		-p 20443:443 \
		-p 25901:5901 \
		-p 26080:6080 \
		-p 26901:6901 \
		ghcr.io/dockenv/boxs:xfce
}

run_cmdide()
{
    docker run -d \
		--name cmdide \
		--hostname cmdide \
		-p 30022:22 \
		-p 30080:80 \
		-e RUN_MODE="remote" \
		-v /Volumes/MacData/Code:/data:rw \
		-v /Volumes/MacData/Code/Devenv/Volumes/nginx:/etc/nginx/conf:rw \
		imxieke/cmdide:latest
}

run_gogs()
{
    docker run \
        --rm \
        --name gogs \
        --hostname gogs \
        -p 10022:22 \
        -p 13000:3000 \
        -v $(pwd)/runtime/data/gogs:/data \
        gogs/gogs:latest
}

run_homestead()
{
    docker run -d \
          -p 30022:22 \
          -p 30080:80 \
          -e RUN_MODE="remote" \
          imxieke/cmdide:homestead
}

run_mariadb()
{
    docker run -d \
		  --name mariadb \
		  -v /Volumes/Data/Volumes/mariadb:/var/lib/mysql \
          -p 3306:3306 \
          -e MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD} \
          mariadb:10.3.8 \
          --character-set-server=utf8mb4 \
          --collation-server=utf8mb4_unicode_ci
}

run_mysql()
{
    MYSQL_PASSWORD=$(grep MYSQL_PASSWORD conf.ini | awk -F '=' '{print $2}')
    docker run -d \
        -p 3306:3306 \
        -p 33060:33060 \
        --hostname=mysql \
        --name=mysql \
        -e MYSQL_ROOT_PASSWORD=${MYSQL_PASSWORD} \
        -v /Volumes/Data/Dev/mysql/docker:/var/lib/mysql \
        ghcr.io/dockenv/mysql:latest \
        --character-set-server=utf8mb4 \
        --collation-server=utf8mb4_unicode_ci
}

run_redis()
{
    docker run --rm -d \
        --hostname=redis \
        --name=redis \
        -p 6379:6379 \
        -v ${CONF_PATH}/redis:/etc/redis \
        -v ${DATA_PATH}/redis:/data \
        -v ${LOGS_PATH}/redis:/var/log/redis \
        ghcr.io/dockenv/redis:latest redis-server /etc/redis/redis.conf
}

case "$1" in
    run)
        if [[ -n "$(command -v run_${2})" ]]; then
            run_${2}
        fi
        ;;
    rm)
        if [[ -n "$(command -v run_${2})" ]]; then
            docker stop "${2}"
            docker rm "${2}"
        fi
        ;;
    stop)
        if [[ -n "$(command -v run_${2})" ]]; then
            docker stop "${2}"
        fi
        ;;
    *)
        if [[ -n "$(command -v run_${1})" ]]; then
            run_${1}
        else
            echo "    Docker Container Runner
rm      stop and remove Container
stop    stop Container
"
        fi
    ;;
esac
