FROM ghcr.io/dockenv/boxs:xfce-base
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv

COPY conf /tmp/conf

ENV USER="boxs" \
    PASSWD="boxs" \
    AUTHORIZED_KEYS='**None**' \
    DEBIAN_FRONTEND=noninteractive \
    TERM=xterm \
    NO_VNC_HOME=/opt/noVNC \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1920x1080 \
    VNC_PASSWD=vncboxs \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    SSH_PORT=22

ENV HOME_DIR=/home/$USER

RUN bash /tmp/conf/bootstrap.sh && rm -fr /tmp/conf/bootstrap.sh

USER ${USER}
WORKDIR ${HOME_DIR}

EXPOSE 22 80 443 6080 ${VNC_PORT} ${NO_VNC_PORT}

CMD ["/bin/bash", "/usr/bin/entrypoint"]
