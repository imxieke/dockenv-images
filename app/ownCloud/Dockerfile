#latest ownCloud in Docker!
FROM php:5.6-apache
MAINTAINER Xiekers <im@xieke.org>

ADD https://download.owncloud.org/download/community/owncloud-latest.zip /var/www/html/
chmod 777 -R /var/www/

EXPOSE 80
CMD ["apache2-foreground"]
