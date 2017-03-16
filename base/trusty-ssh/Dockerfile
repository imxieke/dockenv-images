FROM ubuntu:xenial
MAINTAINER imxieke <imxieke@qq.com>

# Install packages
RUN apt-get update && apt-get upgrade -y && DEBIAN_FRONTEND=noninteractive && \
	apt-get -y install openssh-server pwgen && \
	apt-get clean all && rm -fr /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && \
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config 

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80
CMD ["/run.sh"]