FROM ubuntu:xenial
MAINTAINER Xiekers <imxieke@qq.com>

# Config Development Environment
RUN apt-get update && apt upgrade -y DEBIAN_FRONTEND=noninteractive && \ 
     apt-get -y install openssh-server pwgen curl unzip screen zsh vim git nginx php automake python  python-pip \
     htop nmap fping apt-transport-https ca-certificates  && pip install -U pip && \
     sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" && \
     apt-get remove python3 --purge -y && apt-get autoremove -y --purge && \
     apt-get clean all && rm -r /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    apt-get clean all && rm -r /var/lib/apt/lists/*

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**
ENV PAAS_ROOT password

EXPOSE 22 80
CMD ["/run.sh"]
