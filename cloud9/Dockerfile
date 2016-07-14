FROM imxieke/ubuntu:trusty
MAINTAINER Xiekers <imxieke@qq.com>

ENV C9_WORKSPACE /cloud9/workspace
ENV ROOT_PASS xiaoke
RUN apt-get update && \
    apt-get -y install git curl build-essential supervisor
    
RUN curl -sL https://deb.nodesource.com/setup | sudo bash -
RUN apt-get -y install nodejs

RUN git clone https://github.com/c9/core.git /tmp/c9
RUN cd /tmp/c9 && scripts/install-sdk.sh
RUN mv /tmp/c9 /cloud9
WORKDIR /cloud9

RUN mkdir /cloud9/workspace
VOLUME /cloud9/workspace

ADD supervisord.conf /etc/supervisor/conf.d/
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 8181
ENTRYPOINT /usr/bin/supervisord
