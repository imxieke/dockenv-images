FROM nginx:1.11.1-alpine
MAINTAINER Xiekers <im@xieke.org>

RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
ADD http://ftp.daoapp.io/conf/maven.conf /etc/nginx/conf.d/default.conf

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
