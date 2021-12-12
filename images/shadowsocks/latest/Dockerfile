FROM teddysun/shadowsocks-libev:latest

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

COPY entrypoint.sh /tmp/entrypoint.sh
COPY shadowsocks.json /tmp/shadowsocks.json

ENV PORT    6443
ENV PASSWD	sspass
ENV METHOD  xchacha20-ietf-poly1305

USER root

# RUN rm -fr /etc/service

# CMD sh /tmp/entrypoint.sh
CMD sh
