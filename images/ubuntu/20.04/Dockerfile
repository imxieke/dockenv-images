# Ubuntu 20.04
FROM ubuntu:focal

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" \
	DEBIAN_FRONTEND=noninteractive

RUN . /etc/os-release \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME} main restricted multiverse universe" > /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-backports main restricted multiverse universe" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-proposed main restricted multiverse universe" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-security main restricted multiverse universe" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-updates main restricted multiverse universe" >> /etc/apt/sources.list

CMD ["/usr/bin/bash"]
