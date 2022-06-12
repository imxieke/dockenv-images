FROM alpine:3.16
LABEL MAINTAINER="Cloudflying" \
  MAIL="<oss@live.hk>" \
  org.opencontainers.image.source=https://github.com/dockenv/dockenv

RUN sed -i 's/dl-cdn.alpinelinux.org/repo.huaweicloud.com/g' /etc/apk/repositories

CMD [ "/bin/sh" ]
