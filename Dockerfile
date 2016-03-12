FROM ubuntu:wily
MAINTAINER Xiekers <im@xieke.org>

#install package

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
