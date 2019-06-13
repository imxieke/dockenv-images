FROM imxieke/debian:latest
LABEL MAINTAINER=Sky \
        MAIL=<Sky@gfw.party>

# Install packages
RUN apt-get update \
	&& apt-get upgrade -y \
	&& DEBIAN_FRONTEND=noninteractive \
	&& apt-get -y install openssh-server pwgen \
	&& echo "########## Config sshd #################" \
	&& mkdir -p /var/run/sshd \
	&& sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
	&& sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
	&& sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
	&& echo "#########Clearn Environment###########" \
	&& apt-get autoremove -y --purge \
	&& apt-get clean all \
	&& rm -r /var/lib/apt/lists/*

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80 666 3000 7681 8888
CMD ["/run.sh"]