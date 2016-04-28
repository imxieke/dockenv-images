FROM ubuntu:latest
MAINTAINER Xiekers <im@xieke.org>

RUN apt-get update && apt-get install nginx -y && mkdir -p /etc/nginx/conf.d
#RUN mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
ADD https://raw.githubusercontent.com/imxieke/Dockerfile/master/nginxproxy/default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80
