# Ubuntu 14.10
FROM ubuntu:utopic

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
ENV DEBIAN_FRONTEND noninteractive

RUN sed -i 's/archive.ubuntu.com/repo.huaweicloud.com/g' /etc/apt/sources.list \
	&& sed -i 's/deb\ http:\/\/security/#deb\ http:\/\/security/g' /etc/apt/sources.list

CMD ['bash']
