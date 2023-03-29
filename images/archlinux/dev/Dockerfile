FROM ghcr.io/dockenv/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN pacman -Syy \
    && pacman -S --noconfirm base-devel neovim git \
    && pacman -Scc --noconfirm \
    && rm -fr /var/cache/pacman/pkg/*

CMD /bin/bash
