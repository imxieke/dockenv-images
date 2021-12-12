FROM registry.cn-hongkong.aliyuncs.com/imxieke/archlinux:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV RUN_USER="boxs" \
	PASSWD="boxs" \
	AUTHORIZED_KEYS='**None**' \
	DEBIAN_FRONTEND=noninteractive

ENV HOME_DIR=/home/$RUN_USER

RUN pacman -Syy \
    && pacman -S --noconfirm openssh sudo git zsh neovim net-tools base-devel wget axel \
    && useradd -d /home/${RUN_USER} -m -s /bin/zsh ${RUN_USER} \
	&& echo "${RUN_USER}:${PASSWD}" | chpasswd \
	&& echo "root:${PASSWD}" | chpasswd \
    && echo "${RUN_USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && git clone --depth 1 https://gitee.com/mirr/oh-my-zsh.git ${HOME_DIR}/.oh-my-zsh \
    && cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc \
    && sed -i 's/ZSH_THEME.*/ZSH_THEME="strug"/g' ${HOME_DIR}/.zshrc \
    && su ${RUN_USER} && chsh -s "$(command -v zsh)" \
    && ssh-keygen -A \
    && sed -i 's/^#ClientAliveInterval.*/ClientAliveInterval 60/g' /etc/ssh/sshd_config \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config \
    && sed -i "s/^#ListenAddress 0.0.0.0/ListenAddress 0.0.0.0/g" /etc/ssh/sshd_config \
    && ln -s /bin/nvim /bin/vim \
    && ln -s /bin/nvim /bin/vi \
    && rm -fr /var/cache/pacman/pkg/* \
    && rm -fr /var/lib/pacman/sync/*

USER ${RUN_USER}
WORKDIR ${HOME_DIR}

EXPOSE 22 80

# CMD sudo service ssh start
CMD /usr/bin/bootstrap
