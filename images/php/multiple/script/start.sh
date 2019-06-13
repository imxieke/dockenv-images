#!/usr/bin/env bash
# service php7.3-fpm start
service php7.2-fpm start
# service php7.1-fpm start
# service php7.0-fpm start
service php5.6-fpm start
service nginx start
tail -f /var/log/nginx/access.log