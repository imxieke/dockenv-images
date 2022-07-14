# Ubuntu 14.04
FROM ubuntu:trusty

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
ENV DEBIAN_FRONTEND noninteractive
ENV VERSION_CODENAME=trusty

RUN . /etc/os-release \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME} main restricted multiverse universe" > /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-backports main restricted multiverse universe" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-proposed main restricted multiverse universe" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-security main restricted multiverse universe" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME}-updates main restricted multiverse universe" >> /etc/apt/sources.list

CMD ["/usr/bin/bash"]
