FROM ubuntu:14.04
MAINTAINER Xiekers <im@xieke.org>
RUN apt-get update && apt-get install -y wget unzip apt-transport-https golang
RUN cd /root && pwd
RUN wget http://7d9nal.com2.z0.glb.qiniucdn.com/gogs_v0.9.13_linux_amd64.zip
RUN unzip gogs_v0.9.13_linux_amd64.zip && cd gogs && chmod +x gogs && ls && pwd
RUN ./gogs web
EXPOSE 3000
