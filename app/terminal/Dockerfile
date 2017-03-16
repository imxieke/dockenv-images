FROM daocloud.io/library/debian:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN echo "deb http://mirrors.ustc.edu.cn/debian stable main contrib non-free" > /etc/apt/sources.list && \
    echo "deb http://mirrors.ustc.edu.cn/debian stable-updates main contrib non-free" >> /etc/apt/sources.list

# Install packages
RUN apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive && \
	apt-get -y install openssh-server pwgen c++ g++ pkg-config cmake git vim vim-common libwebsockets-dev libjson-c-dev libssl-dev && \
	git clone https://git.coding.net/tsl0922/ttyd.git /tmp/tydd && \
	cd /tmp/tydd && mkdir -p /tmp/tydd/build && cd /tmp/tydd/build && \
	cmake .. && make && make install && cd ~ && rm -fr /tmp/tydd && \
	apt-get autoremove -y --purge && apt-get clean all && rm -fr /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config 

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**

EXPOSE 22 7681
CMD ["/run.sh"]