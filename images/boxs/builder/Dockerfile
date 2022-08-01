FROM ghcr.io/dockenv/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV RUN_USER="boxs" \
	PASSWD="boxs" \
	AUTHORIZED_KEYS='**None**' \
	DEBIAN_FRONTEND=noninteractive

ENV HOME_DIR=/home/$RUN_USER

COPY conf/makepkg.conf /etc/makepkg.conf

RUN pacman -Syy \
    && pacman -S --noconfirm --overwrite \* \
        openssh git zsh neovim net-tools wget axel curl axel namcap \
        file tree which \
        base-devel dpkg \
        unarchiver unzip unrar p7zip \
        go python python2 python-pip \
        nodejs npm \
        nss alsa-lib libsecret \
        asar electron electron12 electron13 electron16 electron18 \
        gtk2 xdg-utils \
        squashfs-tools \
    && useradd -d /home/${RUN_USER} -c "Packages Builder" -m -s /bin/zsh ${RUN_USER} \
	&& echo "${RUN_USER}:${PASSWD}" | chpasswd \
	&& echo "root:${PASSWD}" | chpasswd \
    && echo "${RUN_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git ${HOME_DIR}/.oh-my-zsh \
    && cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc \
    && sed -i 's/ZSH_THEME.*/ZSH_THEME="strug"/g' ${HOME_DIR}/.zshrc \
    && chown -R ${RUN_USER}:${RUN_USER} ${HOME_DIR} \
    && ssh-keygen -A \
    && sed -i 's/^#ClientAliveInterval.*/ClientAliveInterval 60/g' /etc/ssh/sshd_config \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config \
    && sed -i "s/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g" /etc/ssh/sshd_config \
    && ln -s /bin/nvim /bin/e \
    && ln -s /bin/nvim /bin/vim \
    && ln -s /bin/nvim /bin/vi \
    && pacman -Scc --noconfirm \
    && rm -fr /var/lib/pacman/* \
    && rm -fr /var/cache/pacman/*

USER ${RUN_USER}
WORKDIR ${HOME_DIR}

EXPOSE 22 80

CMD ["/bin/zsh"]
#sudo service ssh start
