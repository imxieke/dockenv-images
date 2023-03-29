# Base Archlinux Image

FROM archlinux/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

ENV PATH="/usr/local/bin:/usr/local/sbin:/bin:/sbin:/usr/bin:/usr/sbin" \
  TZ='Asia/Shanghai'

ADD pacman.conf /etc/pacman.conf

RUN echo "Server = https://repo.huaweicloud.com/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist \
    && rm -fr /etc/localtime \
    && ln --symbolic "/usr/share/zoneinfo/${TZ}" /etc/localtime \
    && echo "${TZ}" > /etc/timezone

CMD /bin/bash
