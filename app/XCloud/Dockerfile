#latest XCloud KODExplorer in Docker!
FROM php:5.6-apache
MAINTAINER Xiekers <im@xieke.org>
ENV BRANCH master
ENV PKG_NAME KODExplorer
ENV DL_URL https://github.com/kalcaddle/KODExplorer/archive/master.zip

RUN apt-get update &&apt-get install wget unzip -y && \
    wget $DL_URL -O /tmp/$PKG_NAME && \
    unzip /tmp/$PKG_NAME -d /tmp/ && \
    mv /tmp/$PKG_NAME-$BRANCH/* /var/www/html/  && \
    rm -fr /tmp/$PKG_NAME-$BRANCH  && \
    rm -fr /tmp/$PKG_NAME && \
    chmod 777 -R /var/www/ && \
    apt-get remove wget unzip -y --purge && \
    apt-get clean all && \
    rm -r /var/lib/apt/lists/*

EXPOSE 80
CMD ["apache2-foreground"]
