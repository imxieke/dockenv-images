FROM alpine:v3.4
MAINTAINER Xiekers <imxieke@qq.com>

RUN set -ex \
            && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.4/main' >> /etc/apk/repositories \
            && apk add -U curl libsodium python \
            && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
            && pip install shadowsocks && apk del curl \
            && rm -rf /var/cache/apk/*

ADD shadowsocks.json /etc/
ADD start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 666
USER nobody
CMD ["sh", "-c", "/start.sh"]
