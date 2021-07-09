#!/usr/bin/env bash

# drush
# extensions

# https://github.com/aerospike/aerospike-client-php

PHP_73_VERSION=$(curl -sL https://www.php.net | grep 'download-link' | grep 8 | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
PHP_74_VERSION=$(curl -sL https://www.php.net | grep 'download-link' | grep 74 | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
PHP_8_VERSION=$(curl -sL https://www.php.net | grep 'download-link' | grep 73 | awk -F '>' '{print $3}' | awk -F '<' '{print $1}')
echo ${PHP_73_VERSION}
echo ${PHP_74_VERSION}
echo ${PHP_8_VERSION}

# curl -sS https://getcomposer.org/installer | php
# https://mirrors.aliyun.com/composer/composer.phar
# mv composer.phar /usr/local/bin/composer
# composer config -g repo.packagist composer https://mirrors.aliyun.com/composer/

#     apt-get install -y --force-yes php7.0-xdebug && \
#     sed -i 's/^/;/g' /etc/php/7.0/cli/conf.d/20-xdebug.ini && \
#     echo "alias phpunit='php -dzend_extension=xdebug.so /var/www/laravel/vendor/bin/phpunit'" >> ~/.bashrc \
#     ;fi
