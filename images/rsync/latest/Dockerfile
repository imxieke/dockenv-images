FROM imxieke/alpine:latest

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

RUN apk update && \
    apk add --no-cache rsync && \
    rm -fr /var/cache/apk/*

CMD [ "/bin/sh" ]
