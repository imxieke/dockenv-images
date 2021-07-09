FROM imxieke/alpine:latest
LABEL MAINTAINER="Sky" \
        MAIL="Sky@gfw.party"

ENV PORT="8838" \
	PASSWD="ssrondocker"

RUN set -ex \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr/shadowsocksr/archive/manyuser.zip

EXPOSE ${PORT}

ENTRYPOINT /usr/bin/ssserver -s 0.0.0.0 -p $PORT -k $PASSWD -m aes-256-cfb -o tls1.2_ticket_auth -O auth_sha1_v4