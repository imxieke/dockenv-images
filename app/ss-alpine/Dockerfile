FROM alpine:3.4
MAINTAINER Xiekers <imxieke@qq.com>

RUN set -ex \
            && echo 'http://dl-cdn.alpinelinux.org/alpine/v3.4/main' >> /etc/apk/repositories \
            && apk add -U curl libsodium python \
            && curl -sSL https://bootstrap.pypa.io/get-pip.py | python \
            && pip install shadowsocks && apk del curl \
            && rm -rf /var/cache/apk/*
            
ADD shadowsocks.json /etc/
USER nobody
EXPOSE 666
CMD ["ssserver","-c","/etc/shadowsocks.json"]
