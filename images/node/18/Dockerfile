FROM ghcr.io/dockenv/alpine:3.16
LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='Node 18'

RUN apk add --no-cache nodejs-current npm yarn

CMD [ "node" ]
