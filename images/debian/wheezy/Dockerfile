# Debian Wheezy (7)
FROM debian:wheezy
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

ENV DEBIAN_FRONTEND=noninteractive
ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
ENV VERSION_CODENAME=wheezy

RUN . /etc/os-release \
    && echo "deb http://archive.debian.org/debian-archive/${ID} ${VERSION_CODENAME} main" > /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-archive/${ID} ${VERSION_CODENAME} contrib" >> /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian-archive/${ID} ${VERSION_CODENAME} non-free" >> /etc/apt/sources.list

CMD ["/bin/bash"]
