FROM alpine:3.4
MAINTAINER Xiekers <im@xieke.org>

ENV SS_VERSION 2.4.7
ENV SERVER_ADDR 0.0.0.0
ENV SERVER_PORT 8388
ENV METHOD      aes-256-cfb
ENV PASSWORD=
ENV TIMEOUT     300
ENV WORKERS     10

RUN buildDeps=" \
		build-base \
		curl \
		linux-headers \
		openssl-dev \
		tar \
	"; \
	set -x \
	&& apk add --update openssl \
	&& apk add $buildDeps \
	&& curl -SL "https://github.com/shadowsocks/shadowsocks-libev/archive/$SS_VERSION.tar.gz" -o ss.tar.gz \
	&& mkdir -p /usr/src/ss \
	&& tar -xf ss.tar.gz -C /usr/src/ss --strip-components=1 \
	&& rm ss.tar.gz \
	&& cd /usr/src/ss \
	&& ./configure \
	&& make install \
	&& cd / \
	&& rm -fr /usr/src/ss \
	&& apk del $buildDeps \
	&& rm -rf /var/cache/apk/*

EXPOSE $SERVER_PORT
CMD /usr/local/bin/ss-server -s "$SERVER_ADDR"              \
             -p "$SERVER_PORT"              \
             -k "${PASSWORD:-$(hostname)}"  \
             -m "$METHOD"                   \
             -t "$TIMEOUT"                  \
             --workers "$WORKERS"           \
             --fast-open
