FROM kalilinux/kali-linux-docker:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN echo "deb http://ftp.free.fr/pub/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://ftp.free.fr/pub/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list && \
	apt-get -y update && apt-get upgrade -y && \
	apt-get -y dist-upgrade && DEBIAN_FRONTEND=noninteractive && \
    apt-get autoremove -y --purge && \
    apt-get clean all && \
    rm -r /var/lib/apt/lists/*

CMD ["/bin/bash"]