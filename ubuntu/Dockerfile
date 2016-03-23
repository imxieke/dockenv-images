FROM ubuntu:wily
MAINTAINER Xiekers <im@xieke.org>

# Ensure UTF-8
RUN locale-gen en_US.UTF-8
ENV LANG       en_US.UTF-8
ENV LC_ALL     en_US.UTF-8

#Replace Sources.list
ADD sources.list /etc/apt/sources.list.bak

# Install packages
RUN apt-get update -y && apt-get -y upgrade && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server ca-certificates pwgen supervisor git tar vim-nox vim-syntax-go wget  --no-install-recommends && apt-get clean  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80 666 888 8888
CMD ["/run.sh"]
