# Debian Buster (10)
FROM debian:buster
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

ENV DEBIAN_FRONTEND noninteractive \
	PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

RUN sed -i 's/deb.debian.org/repo.huaweicloud.com/g' /etc/apt/sources.list \
	&& sed -i 's/security.debian.org/repo.huaweicloud.com/g' /etc/apt/sources.list

CMD ['/bin/bash']
