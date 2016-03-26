FROM ubuntu:trusty
MAINTAINER Xiekers <im@xieke.org>

# Install packages
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server pwgen
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN apt-get upgrade -y && apt-get install vim git apche2 php5 
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

#Replace Sources.list
ADD sources.list /etc/apt/sources.list.bak

ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80 666 888 8888
CMD ["/run.sh"]
