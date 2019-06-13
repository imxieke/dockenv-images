FROM registry.cn-hongkong.aliyuncs.com/imxieke/archlinux:vncenv
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"
ENV HOME=/root
ENV AUTHORIZED_KEYS **None** \
    DISPLAY=:1 \
    TERM=xterm \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    NO_VNC_HOME=$HOME/noVNC \
    VNC_COL_DEPTH=32 \
    VNC_RESOLUTION=1360x768 \
    VNC_PW=123456 \
    VNC_VIEW_ONLY=false

WORKDIR /root

ADD run.sh /

RUN chmod +x /*.sh

ADD conf/.xinitrc /root/.xinitrc
ADD conf/.ratpoisonrc /root/.ratpoisonrc
ADD conf/.xsession /root/.xsession
ADD conf/vnc/xstartup /root/.vnc/xstartup

EXPOSE $VNC_PORT $NO_VNC_PORT 22

CMD /run.sh
