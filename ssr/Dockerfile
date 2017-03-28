FROM alpine:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN set -ex \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr/shadowsocksr/archive/manyuser.zip

ENTRYPOINT ["/usr/bin/ssserver"]