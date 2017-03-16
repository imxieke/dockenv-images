FROM daocloud.io/imxieke/archlinux:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN echo "Server = http://mirrors.ustc.edu.cn/archlinux/\$repo/os/\$arch" >/etc/pacman.d/mirrorlist
RUN pacman --noconfirm --force -Syyu
RUN pacman -S  --noconfirm openssh sudo which tar curl grep && \
	rm -fr /var/cache/pacman/pkg/* && pacman -Scc --noconfirm

RUN mkdir -p /var/run/sshd && \
	ssh-keygen -A && \
	sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config 

ADD run.sh /run.sh
RUN chmod +x /*.sh

EXPOSE 22
CMD /run.sh