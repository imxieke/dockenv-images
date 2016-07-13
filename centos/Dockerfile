FROM centos:6
MAINTAINER Xiekers <im@xieke.org>
RUN cd /etc/yum.repos.d/
RUN yum install -y wget unzip vim 
RUN wget http://104.255.221.123/nginx.repo
RUN yum update -y
RUN yum  install -y nginx php php-mbstring php-ioncube-loader php-mysql php-gd php-curl
RUN chmod -R 777 /var/www
EXPOSE  80
RUN echo "Hello World DaoCloud!"
