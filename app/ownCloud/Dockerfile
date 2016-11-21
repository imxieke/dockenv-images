#latest ownCloud in Docker!
FROM php:5.6-apache
MAINTAINER Xiekers <im@xieke.org>

RUN apt-get update &&apt-get install wget unzip -y && \
    wget https://download.owncloud.org/download/community/owncloud-latest.zip -O /tmp/owncloud-latest.zip && \
    unzip owncloud-latest.zip -O /tmp/ && mv /tmp/owncloud/* /var/www/html/  && \
    rm -fr /tmp/owncloud  && rm -fr /tmp/owncloud-latest.zip && chmod 777 -R /var/www/ && \
    apt-get remove wget unzip -y && apt-get clean all && rm -r /var/lib/apt/lists/*

EXPOSE 80
CMD ["apache2-foreground"]
