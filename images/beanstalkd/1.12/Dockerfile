FROM ghcr.io/dockenv/alpine:3.14

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

RUN apk add --no-cache beanstalkd

VOLUME /var/lib/beanstalkd/data

EXPOSE 11300

CMD ["/usr/bin/beanstalkd"]
