FROM ghcr.io/dockenv/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN pacman -Syy \
    && pacman -S --noconfirm base-devel neovim git \
    && rm -fr /var/cache/pacman/pkg/* \
    && pacman -Scc --noconfirm \
    && rm -fr /var/lib/pacman/*

CMD /bin/bash
