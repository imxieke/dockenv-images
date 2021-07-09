FROM registry.cn-hongkong.aliyuncs.com/imxieke/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN pacman -Syyu --noconfirm \
    && pacman -S --noconfirm gcc make cmake neovim git \
    && rm -fr /var/cache/pacman/pkg/* \
    && pacman -Scc --noconfirm \
    && rm -fr /var/lib/pacman/*

CMD /bin/bash
