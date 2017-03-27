FROM nfnty/arch-mini:latest
MAINTAINER imxieke <imxieke@qq.com>

ENV PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
RUN pacman --noconfirm --force -Syyu && \
	rm -fr /var/cache/pacman/pkg/* && pacman -Scc --noconfirm

CMD ["bash"]