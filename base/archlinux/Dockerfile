FROM nfnty/arch-mini:latest
MAINTAINER imxieke <imxieke@qq.com>

RUN pacman --noconfirm --force -Syyu && \
	rm -fr /var/cache/pacman/pkg/* && pacman -Scc --noconfirm

CMD ["bash"]