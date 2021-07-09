FROM archlinux/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" \
  LANG='en_US.UTF-8' \
  LANGUAGE='en_US:en' \
  LC_TIME='en_US.UTF-8' \
  LC_PAPER='en_US.UTF-8' \
  LC_MEASUREMENT='en_US.UTF-8' \
  TZ='Asia/Shanghai'

RUN echo "Server = https://mirrors.aliyun.com/archlinux/\$repo/os/\$arch" > /etc/pacman.d/mirrorlist\
    && rm -fr /etc/localtime \
    && ln --symbolic "/usr/share/zoneinfo/${TZ}" /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

CMD /bin/bash
