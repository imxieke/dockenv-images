FROM alpine:edge
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
RUN echo "http://mirrors.aliyun.com/alpine/edge/main"  >/etc/apk/repositories \
	&& echo "http://mirrors.aliyun.com/alpine/edge/community" >>/etc/apk/repositories \
	&& rm -fr /var/cache/apk/* \
	&& rm -fr /tmp/*
