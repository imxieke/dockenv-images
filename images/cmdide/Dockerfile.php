FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV USER=laravel \
	PASSWD=laravel
ENV HOME=/home/${USER}
ADD script/laravel-alpine.sh /tmp/build.sh
ADD script/alpine-runenv.sh /bin/runenv

RUN chmod +x /tmp/build.sh \
	&& chmod +x /bin/runenv \
	&& sh /tmp/build.sh \
	&& rm -fr /tmp/*

USER ${USER}
WORKDIR ${HOME}
EXPOSE 80
CMD ["/bin/sh"]
