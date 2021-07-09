FROM registry.cn-hongkong.aliyuncs.com/imxieke/ubuntu:20.04
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD script/bootstrap.sh /usr/bin/boxs
ADD conf.d/.zshrc /tmp/.zshrc

# COPY ./unity/supervisor.conf /etc/supervisor/conf.d/
# COPY ./unity/xsession ${HOME}/.xsession
# COPY ./unity/startup.sh /bin/startup.sh
# COPY ./unity/unity.sh ${SHELL_DIR}/

# ADD ./xfce/ $HOME/
# ADD ./script $STARTUPDIR

# ADD conf/.xinitrc /root/.xinitrc
# ADD conf/.ratpoisonrc /root/.ratpoisonrc
# ADD conf/.xsession /root/.xsession
# ADD conf/vnc/xstartup /root/.vnc/xstartup

ENV USER="boxs" \
	PASSWD="boxs" \
	AUTHORIZED_KEYS='**None**' \
	HOME_DIR=/home/$USER \
	DEBIAN_FRONTEND=noninteractive \
	TERM=xterm \
    NO_VNC_HOME=/opt/noVNC \
    VNC_COL_DEPTH=24 \
    VNC_RESOLUTION=1360x768 \
    VNC_PW=boxs \
    VNC_VIEW_ONLY=false \
    DISPLAY=:1 \
    VNC_PORT=5901 \
    NO_VNC_PORT=6901 \
    NO_VNC_HOME=/home/ubuntu/.noVNC \
    INST_SCRIPTS=/home/ubuntu/install \
    STARTUPDIR=/startup

RUN chmod +x /usr/bin/boxs && bash /usr/bin/boxs

USER ${USER}
WORKDIR ${HOME_DIR}

# VOLUME ['/var/www']
# VOLUME ['/etc/nginx/conf.d/']
EXPOSE 22 80 443 6080 ${VNC_PORT} ${NO_VNC_PORT}

CMD ['/bin/zsh']
CMD ["/bin/bash", "/bin/startup.sh"]
ENTRYPOINT ["/bin/bash", "/bin/startup.sh"]
CMD ["--wait"]
