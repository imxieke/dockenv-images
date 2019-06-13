#!/usr/bin/env sh

echo "=> Insatll Depends and tools "
apk add --no-cache shadow sudo neovim git zsh wget curl jq openssl

echo "=> Insatll Nginx Web Server "
apk add --no-cache nginx nginx-mod-rtmp nginx-mod-http-cache-purge 

echo "=> Insatll PHP Run Environment "
apk add --no-cache php7-fpm php7-openssl \
		php7-mysqli php7-intl php7-openssl php7-dba php7-pear php7-tokenizer \
		php7-gmp php7-pdo_mysql php7-xsl php7-pecl-event php7-embed php7-ftp \
		php7-mysqlnd php7-enchant php7-pspell php7-snmp php7-pcntl \
		php7-fileinfo php7-mbstring php7-dev php7-xmlrpc php7-xmlreader php7-apcu \
		php7-pdo_sqlite php7-exif php7-recode php7-opcache php7-ldap php7-posix \
		php7-session php7-gd php7-gettext php7-mailparse php7-json php7-xml php7-iconv \
		php7-sysvshm php7-curl php7-shmop php7-odbc php7-phar php7-pdo_pgsql php7-imap \
		php7-pdo_dblib php7-pgsql php7-pdo_odbc php7-zip php7-ctype php7-sqlite3 \
		php7-mcrypt php7-bcmath php7-calendar php7-tidy  php7-dom php7-sockets php7-zmq \
		php7-memcached php7-soap  php7-sysvmsg php7-zlib php7-pdo php7-bz2 \
		php7-simplexml php7-xmlwriter php7-pecl-redis \
		php7-pecl-yaml php7-pecl-mongodb php7-pecl-mcrypt php7-pecl-memcached composer

# echo "=> Clean Cache And Package"
# rm -fr /var/cache/apk/*

# Config Nginx
mkdir -p /run/nginx
mkdir -p /var/log/nginx
mkdir -p /var/lib/nginx/logs/

# Create Volume Mount Point
mkdir -p /code

# Create nginx vhost Config directory
mkdir -p /etc/nginx/vhost.d
Remove Default Vhost config
# 
rm -fr /etc/nginx/conf.d/default.conf

touch /run/nginx/nginx.pid
touch /var/lib/nginx/logs/access.log
touch /var/lib/nginx/logs/error.log

chown -R nginx:nginx /run/nginx
chown -R nginx:nginx /var/log/nginx
chown -R nginx:nginx /var/lib/nginx
echo "=> Create User ${USER} And Change Password"
useradd -d /home/${USER} -m -s /bin/sh ${USER}
echo "${USER}:${PASSWD}" | chpasswd
echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
echo '=> Config oh my zsh'
echo "=> Cloning oh my zsh to $HOME"
git clone --depth=1 https://git.dev.tencent.com/imxieke/ohmyzsh.git ${HOME}/.oh-my-zsh
cp ${HOME}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME}/.zshrc
chown -R ${USER}:${USER} ${HOME}
sed -i "s/${USER}:\/bin\/sh/${USER}:\/bin\/zsh/g" /etc/passwd
sed -i "s/robbyrussell/strug/g" ${HOME}/.zshrc

echo "=> Set Composer Registry"
sudo -Hu ${USER} composer config -g repo.packagist composer https://packagist.laravel-china.org
