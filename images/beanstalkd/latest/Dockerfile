FROM ghcr.io/dockenv/alpine:latest

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

RUN apk add --no-cache beanstalkd

VOLUME /var/lib/beanstalkd/data

EXPOSE 11300

CMD ["/usr/bin/beanstalkd"]
