FROM php:latest

LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN apt-get update \
    && apt-get install -y curl \
    && curl -sL https://github.com/ptrofimov/beanstalk_console/archive/master.tar.gz | tar xvz -C /tmp \
    && mv /tmp/beanstalk_console-master /source
    && apt-get remove --purge -y curl && \
    && apt-get autoclean \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 2080

CMD bash -c 'BEANSTALK_SERVERS=$BEANSTALKD_PORT_11300_TCP_ADDR:11300 php -S 0.0.0.0:2080 -t /source/public'
