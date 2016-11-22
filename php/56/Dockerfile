FROM imxieke/base:jessie
MAINTAINER Xiekers <imxieke@qq.com>

RUN apt-get update && \
      DEBIAN_FRONTEND=noninteractive apt-get -y install \
      apache2 libapache2-mod-php5 php5 php5-mysql php5-odbc php5-xcache && \
      apt-get clean && rm -r /var/lib/apt/lists/*

RUN a2dismod mpm_event rewrite

COPY apache2-foreground /usr/local/bin/
EXPOSE 80 443
CMD ["apache2-foreground"]
