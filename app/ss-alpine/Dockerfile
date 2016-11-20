FROM alpine:v3.4
MAINTAINER Xiekers <imxieke@qq.com>

RUN set -ex \
            && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.4/main' >> /etc/apk/repositories \
            && apk add -U curl libsodium python \
            && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
            && pip install shadowsocks && apk del curl \
            && rm -rf /var/cache/apk/*

# Shadowsocks Configure:
ENV SS_SERVER_ADDR 0.0.0.0
ENV SS_SERVER_PORT 666
ENV SS_PASSWORD password
ENV SS_METHOD aes-256-cfb
ENV SS_TIMEOUT 300
ENV SS_USER nobody

# Default Shadowsocks configure file
#ADD shadowsocks.json /etc/

ADD start.sh /start.sh
RUN chmod +x /start.sh
USER $SS_USER
EXPOSE $SS_SERVER_PORT
CMD ["sh", "-c", "/start.sh"]
