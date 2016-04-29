FROM ubuntu:latest
MAINTAINER Xiekers <im@xieke.org>

RUN apt-get update && apt-get install nginx -y && ls /etc/nginx/conf.d #&& mkdir -p /etc/nginx/conf.d
RUN mv /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
ADD https://raw.githubusercontent.com/imxieke/Dockerfile/master/nginxproxy/dr.xieke.org.conf /etc/nginx/sites-available/default
ADD r.npm.xieke.org.conf /etc/nginx/conf.d/r.npm.xieke.org.conf

EXPOSE 80
CMD ["service nginx start"]
