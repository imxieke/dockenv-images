#!/usr/bin/env bash
export LC_ALL C.UTF-8
DEBIAN_FRONTEND=noninteractive
TZ=Asia/Shanghai

sudo
mysql-client # or mariadb-client
rabbitmq-c
apt-utils
beanstalkd
phpunit
inotify-tools
wget
gnupg
unzip
composer
git
vim #(neovim)
tmux # .tmux.conf
tmuxinator # ~/.tmuxinator/init.yml
supervisor


ln -fs /etc/nginx/sites-available/ /etc/nginx/sites-enabled/

echo extension=tideways_xhprof.so > /etc/php/7.4/mods-available/tideways.ini
RUN sed -i -e "s/^zlib\.output_compression\ = .*/zlib\.output_compression = \On/g" /etc/php/7.4/fpm/php.ini
RUN sed -i -e "s/^;max_input_vars\ = .*/max_input_vars\ =\ 20000/g" /etc/php/7.4/fpm/php.ini
RUN sed -i -e "s/^listen\ = .*/listen = \/var\/run\/php-fpm\.sock/g" /etc/php/7.4/fpm/pool.d/www.conf
RUN sed -i -e "s/^error_log\ = .*/error_log = \/var\/log\/php-fpm\.log/g" /etc/php/7.4/fpm/php-fpm.conf
RUN sed -i -e "s/^bind\-address/#bind\-address/g" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i -e "s/^#general_log/general_log/g" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i -e "s/^query_cache_limit\ .*/query_cache_limit\ =\ 0M/g" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i -e "s/^query_cache_size\ .*/query_cache_size\ =\ 0M/g" /etc/mysql/mariadb.conf.d/50-server.cnf
RUN sed -i -e "s/^#BEANSTALKD_EXTRA=.*/BEANSTALKD_EXTRA=\"-z\ 524280\"/g" /etc/default/beanstalkd
RUN sed -i -e "s/'extension'.*$/'extension'\ =>\ 'tideways_xhprof',/g" /var/www/xhgui-branch/config/config.default.php

# 设置时区
apk --no-cache add tzdata \
cp "/usr/share/zoneinfo/$TZ" /etc/localtime
echo "$TZ" > /etc/timezone

curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin/ --filename=composer

# Add a non-root user to prevent files being created with root permissions on host machine.
ARG PUID=1000
ARG PGID=1000
RUN groupadd -g $PGID laradock && \
    useradd -u $PUID -g laradock -m laradock


rm -f /etc/service/sshd/down && \
    cat /tmp/id_rsa.pub >> /root/.ssh/authorized_keys \
    && cat /tmp/id_rsa.pub >> /root/.ssh/id_rsa.pub \
    && cat /tmp/id_rsa >> /root/.ssh/id_rsa \
    && rm -f /tmp/id_rsa* \
    && chmod 644 /root/.ssh/authorized_keys /root/.ssh/id_rsa.pub \
    && chmod 400 /root/.ssh/id_rsa

#RUN git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
#RUN git clone https://github.com/topone4tvs/vim-php-ide-use-vundle.git
#RUN cp vim-php-ide-use-vundle.git/_vimrc ./.vimrc && rm -rf vim-php-ide-use-vundle.git
#RUN nohup vim +PluginInstall +qall > /dev/null &2>1 &