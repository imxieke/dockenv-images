FROM registry.cn-hangzhou.aliyuncs.com/imxieke/kali:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN echo "deb http://mirrors.ustc.edu.cn/kali/ kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://mirrors.ustc.edu.cn/kali/ kali-rolling main contrib non-free" >> /etc/apt/sources.list && \
	apt-get -y update && apt-get upgrade -y && \
	apt-get -y dist-upgrade && DEBIAN_FRONTEND=noninteractive && \
    apt-get autoremove -y --purge && \
    apt-get clean all && \
    rm -r /var/lib/apt/lists/*

CMD ["/bin/bash"]