FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:latest

LABEL MAINTAINER="Sky" \
        MAIL="Sky@gfw.party"

ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 6443
ENV PASSWORD	shadowpass
ENV METHOD      aes-256-gcm
ENV TIMEOUT     300
ENV DNS 		8.8.8.8,8.8.4.4
ENV ARGS=
ENV SHADOW_VER 3.2.5

RUN set -ex \
 # Build environment setup
 && apk add --no-cache --virtual .build-deps \
      autoconf automake build-base libc-dev c-ares-dev libev-dev libtool libsodium-dev \
      linux-headers mbedtls-dev pcre-dev wget asciidoc xmlto gettext-dev \
 # Build & install
 && wget https://mirrors.xieke.org/Src/shadowsocks-libev-${SHADOW_VER}.tar.gz -O /tmp/shadowsocks-libev-${SHADOW_VER}.tar.gz \
 && mkdir -p /tmp/shadowsocks \
 && tar -xvf /tmp/shadowsocks-libev-${SHADOW_VER}.tar.gz -C /tmp/shadowsocks \
 && cd /tmp/shadowsocks/shadowsocks-libev-${SHADOW_VER} \
 && ./configure --prefix=/usr --disable-documentation \
 && make install \
 && apk del .build-deps \
 # Runtime dependencies setup
 && apk add --no-cache \
      rng-tools \
      $(scanelf --needed --nobanner /usr/bin/ss-* \
      | awk '{ gsub(/,/, "\nso:", $2); print "so:" $2 }' \
      | sort -u) \
 && rm -rf /tmp/*

USER nobody

CMD exec ss-server \
      -s $SERVER_ADDR \
      -p $SERVER_PORT \
      -k ${PASSWORD} \
      -m $METHOD \
      -t $TIMEOUT \
      -d $DNS \
      -u \
      $ARGS
