FROM debian:jessie
MAINTAINER Xiekers <imxieke@qq.com>

RUN apt-get update && DEBIAN_FRONTEND=noninteractive &&　＼
      apt-get -y install apache2 libapache2-mod-php5 php5 php5-curl php5-gd　php5-mysql php5-mysqlnd php5-odbc ＼
      php5-xcache php5-imap php5-smtp && \
      apt-get clean && rm -r /var/lib/apt/lists/*

RUN a2dismod mpm_event && a2enmod mpm_prefork ssl　rewrite && a2ensite default-ssl && \
      ln -sf /dev/stdout /var/log/apache2/access.log && \
    　ln -sf /dev/stderr /var/log/apache2/error.log

COPY apache2-foreground /usr/local/bin/
EXPOSE 80 443
CMD ["apache2-foreground"]
