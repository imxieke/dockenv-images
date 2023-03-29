FROM ghcr.io/dockenv/archlinux:base
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN ln -sf /proc/self/mounts /etc/mtab \
    && pacman -Syy \
    # Init keyring
    && pacman-key --init \
    && pacman -S --noconfirm archlinux-keyring \
    # && pacman -Su --noconfirm \
    && pacman -Scc --noconfirm \
    && rm -fr /var/cache/pacman/pkg/* \
    && rm -fr /var/lib/pacman/sync/*.db

CMD /bin/bash
