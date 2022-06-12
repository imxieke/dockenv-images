# Ubuntu 21.10
FROM ubuntu:22.10

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" \
    DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/repo.huaweicloud.com/g' /etc/apt/sources.list \
    && sed -i 's/deb\ http:\/\/security/#deb\ http:\/\/security/g' /etc/apt/sources.list

CMD ['/bin/bash']
