FROM ghcr.io/dockenv/alpine:3.16
LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='Node 16'

RUN apk add --no-cache nodejs npm yarn

CMD [ "node" ]
