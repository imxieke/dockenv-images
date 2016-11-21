FROM kalilinux/kali-linux-docker
MAINTAINER Xiekers <imxieke@qq.com>

RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list

RUN  apt-get -y update && apt-get -y dist-upgrade && DEBIAN_FRONTEND=noninteractive && \ 
     apt-get -y install openssh-server pwgen apt-transport-https ca-certificates automake autoconf python  python-pip apt-utils \
     curl unzip screen zsh vim git nginx php nodejs npm htop nmap fping && pip install -U pip && \
     apt-get autoremove -y --purge && apt-get clean all && rm -r /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config && \
    apt-get clean all && rm -r /var/lib/apt/lists/*

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**
ENV PAAS_ROOT password

EXPOSE 22 80 8080 
CMD ["/run.sh"]
