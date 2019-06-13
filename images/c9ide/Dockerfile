FROM imxieke/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

ENV AUTHORIZED_KEYS **None**

RUN pacman --noconfirm --force -Syyu \
	&& pacman -S --noconfirm --force sed shadow openssh sudo \
	&& pacman -Scc --noconfirm \
	&& rm -fr /var/cache/pacman/pkg/* \
	&& rm -fr /var/lib/pacman/* \
	&& mkdir -p /var/run/sshd \
	&& sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config \
	&& sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config \
	&& sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config \
	&& ssh-keygen -A

EXPOSE 22 80

CMD /run.sh