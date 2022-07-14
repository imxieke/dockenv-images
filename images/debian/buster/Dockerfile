# Debian Buster (10)
FROM debian:buster
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

ENV DEBIAN_FRONTEND noninteractive
ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
ENV VERSION_CODENAME=buster

RUN . /etc/os-release \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME} main" > /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME} contrib" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID} ${VERSION_CODENAME} non-free" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID}-security ${VERSION_CODENAME}/updates main" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID}-security ${VERSION_CODENAME}/updates contrib" >> /etc/apt/sources.list \
    && echo "deb http://repo.huaweicloud.com/${ID}-security ${VERSION_CODENAME}/updates non-free" >> /etc/apt/sources.list

CMD ["/bin/bash"]
