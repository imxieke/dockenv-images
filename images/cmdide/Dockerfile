FROM imxieke/php:multiple
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD script/build.sh /bin/build.sh
ADD script/cmdide.sh /bin/cmdide
ADD script/run.sh /bin/run.sh

ENV RUN_MODE="local"
ENV USER "cmdide"
ENV PASSWD "cmdide"
ENV AUTHORIZED_KEYS **None**
ENV HOME_DIR=/home/$USER

RUN chmod +x /build.sh \
	&& chmod +x /bin/cmdide \
	&& chmod +x /bin/run.sh \
    && bash /build.sh

USER ${USER}
WORKDIR ${HOME_DIR}

VOLUME ['/var/www'] 
VOLUME ['/etc/nginx/conf.d/'] 
EXPOSE 22 80 443

CMD /bin/run.sh