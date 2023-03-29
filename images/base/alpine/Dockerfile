FROM ghcr.io/dockenv/alpine:3.16
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-muslc-amd64 /usr/bin/tini

RUN chmod +x /usr/bin/tini

CMD ["sh"]
