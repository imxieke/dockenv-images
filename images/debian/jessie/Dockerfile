# Debian Jessie (8)
FROM debian:jessie
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV DEBIAN_FRONTEND noninteractive \
	PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

RUN sed -i 's/deb.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list \
	&& sed -i 's/security.debian.org/mirrors.aliyun.com/g' /etc/apt/sources.list

CMD ['/bin/bash']
