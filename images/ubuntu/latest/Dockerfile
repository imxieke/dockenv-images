# Ubuntu Latest
FROM ubuntu:latest

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='PHP latest'

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin" \
	DEBIAN_FRONTEND=noninteractive

RUN sed -i 's/archive.ubuntu.com/repo.huaweicloud.com/g' /etc/apt/sources.list \
	&& sed -i 's/deb\ http:\/\/security/#deb\ http:\/\/security/g' /etc/apt/sources.list

CMD ["/usr/bin/bash"]
