FROM registry.cn-hangzhou.aliyuncs.com/imxieke/trusty:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN   sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
      && apt-get update -y && apt upgrade -y \
      && apt-get -y install debconf autoconf wget apache2 php5 php5-gd php5-mysql php5-odbc php5-curl php5-sqlite php5-mssql php5-pgsql php5-mcrypt php5-imap php5-ldap \ 
      && rm -r /var/lib/apt/lists/* \
      && rm -fr /var/www/html/* \
      && wget https://github.com/Xiekers/Storage/raw/master/Code/tz.php -O /var/www/html/index.php \
      && apt-get clean && apt-get remove -y --purge wget autoconf

COPY  run.sh /usr/local/bin/
RUN   chmod +x /usr/local/bin/run.sh
EXPOSE 80 443
CMD ["run.sh"]
