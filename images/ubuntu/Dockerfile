# Ubuntu 18.10
FROM ubuntu:cosmic

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" \
	DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
	&& sed -i 's/deb\ http:\/\/security/#deb\ http:\/\/security/g' /etc/apt/sources.list \
	&& apt update -y --fix-missing \
	&& apt upgrade -y \
	&& apt install -y tzdata \
	&& rm -fr /etc/localtime \
	&& rm -fr /etc/timezone \
	&& ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
	&& echo "Asia/Shanghai" > /etc/timezone \
	&& apt autoremove -y \
	&& apt-get clean all \
	&& rm -fr /var/lib/apt/lists/*

CMD ['/bin/bash']
