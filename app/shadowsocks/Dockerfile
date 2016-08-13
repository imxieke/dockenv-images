FROM ubuntu:trusty
MAINTAINER Xiekers <im@xieke.org>

RUN apt-get update && \
    apt-get install -y python-pip
RUN pip install shadowsocks==2.8.2 && \
    apt-get clean all && \
    rm -r /var/lib/apt/lists/*

ENTRYPOINT ["/usr/local/bin/ssserver"]
