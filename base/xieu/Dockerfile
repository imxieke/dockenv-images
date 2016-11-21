FROM ubuntu:xenial
MAINTAINER Xiekers <imxieke@qq.com>

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

# Install packages
RUN apt-get update && \
     DEBIAN_FRONTEND=noninteractive && \ 
     apt-get -y install openssh-server pwgen vim git curl unzip screen automake python  python-pip apt-transport-https ca-certificates

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    apt-get clean all && rm -r /var/lib/apt/lists/*

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80
CMD ["/run.sh"]
