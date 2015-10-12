FROM ubuntu:14.04
MAINTAINER Xiaoke <im@xieke.org> 

#Change Sources.list
RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
RUN echo "deb http://mirrors.xieke.org/ubuntu trusty multiverse" >> /etc/apt/sources.list
RUN echo "deb http://mirrors.xieke.org/ubuntu trusty-updates multiverse" >> /etc/apt/sources.list

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive
RUN apt-get -y upgrade

#System Apps
RUN apt-get -y install openssh-server pwgen wget unzip curl vim git subversion screen unrar p7zip-full p7zip-rar aria2
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

#Basic RequieMent Linux+Apahce2+PHP+MYSQL
RUN apt-get -y install mysql-server mysql-client apache2 php5-fpm php5-mysql php-apc pwgen python-setuptools  unzip

# Wordpress Requirements
RUN apt-get -y install php5-curl php5-gd php5-intl php-pear php5-imagick php5-imap php5-mcrypt php5-memcache php5-ming php5-ps php5-pspell php5-recode php5-sqlite php5-tidy php5-xmlrpc php5-xsl libapache2-mod-php5 php5-mcrypt php5-cli

#Add Cloud 
#RUN git clone https://github.com/easychen/KODExplorer.git  /var/www/html
RUN chmod 777 /var/www

#RUN mkdir cldata
ADD aria2.conf /cldata/aria2.conf
COPY init.sh /cldata/init.sh
COPY init.php /cldata/init.php
RUN chmod +x /cldata/init.sh

WORKDIR /var/www/html/comic
VOLUME /var/www/html/comic

ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80 6800 443
CMD ["/run.sh"]