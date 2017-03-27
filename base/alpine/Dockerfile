FROM alpine:3.5
MAINTAINER imxieke <imxieke@qq.com>
ENV ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.5/main"  >/etc/apk/repositories && \
	echo "http://mirrors.ustc.edu.cn/alpine/v3.5/community" >>/etc/apk/repositories && \
	apk add --update && rm -fr /var/cache/apk/* && rm -fr /tmp/*