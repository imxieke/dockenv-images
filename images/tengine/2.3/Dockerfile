FROM ghcr.io/dockenv/ubuntu:21.04

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

ADD build.sh /tmp/build.sh

RUN sh /tmp/build.sh && rm -fr /tmp/* && rm -fr /tmp/.build

EXPOSE 80 443

CMD ["tengine", "-g", "daemon off;"]
