FROM registry.cn-hangzhou.aliyuncs.com/imxieke/archlinux:base
MAINTAINER imxieke <imxieke@qq.com>

RUN pacman --noconfirm --force -Syyu && \
	rm -fr /var/cache/pacman/pkg/* && pacman -Scc --noconfirm

CMD ["bash"]