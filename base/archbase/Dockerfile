FROM registry.us-west-1.aliyuncs.com/imxieke/archbase:latest
MAINTAINER imxieke <imxieke@qq.com>

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
RUN echo "Server = http://mirrors.kernel.org/archlinux/\$repo/os/\$arch" >/etc/pacman.d/mirrorlist && \
	pacman --noconfirm --force -Syyu && \
	rm -fr /var/cache/pacman/pkg/* && pacman -Scc --noconfirm

CMD ["bash"]