# Deepin panda Latest
FROM bestwu/deepin:panda
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV DEBIAN_FRONTEND noninteractive \
	PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"

RUN apt update -y --fix-missing \
	&& apt --fix-broken install \
	&& apt upgrade -y \
	&& apt autoremove -y \
	&& apt-get clean all \
	&& rm -fr /var/lib/apt/lists/*

CMD ['/bin/bash']