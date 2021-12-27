FROM registry.cn-hongkong.aliyuncs.com/imxieke/ubuntu:20.04
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD bootstrap.sh /usr/bin/bootstrap

ENV USER="boxs" \
	PASSWD="boxs" \
	AUTHORIZED_KEYS='**None**' \
	DEBIAN_FRONTEND=noninteractive \
    SSH_PORT=22

ENV HOME_DIR=/home/$USER

RUN chmod +x /usr/bin/bootstrap \
    && apt update -y \
    && apt install -y --no-install-recommends openssh-server openssh-sftp-server sudo git zsh neovim net-tools apt-transport-https software-properties-common \
    && useradd -d /home/${USER} -m -s /bin/zsh ${USER} \
	&& echo "${USER}:${PASSWD}" | chpasswd \
	&& echo "root:${PASSWD}" | chpasswd \
    && echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers \
    && git clone --depth 1 https://gitee.com/mirr/oh-my-zsh.git ${HOME_DIR}/.oh-my-zsh \
    && cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc \
    && sed -i 's/ZSH_THEME.*/ZSH_THEME="strug"/g' ${HOME_DIR}/.zshrc \
    && su ${USER} && chsh -s "$(command -v zsh)" \
    && sed -i 's/^#ClientAliveInterval.*/ClientAliveInterval 60/g' /etc/ssh/sshd_config \
    && sed -i 's/^#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config \
    && sed -i 's/^#Port.*/Port ${SSH_PORT}/g' /etc/ssh/sshd_config

USER ${USER}
WORKDIR ${HOME_DIR}

EXPOSE 22 80

# CMD [ "/bin/bash" ]udo service ssh start
CMD /usr/bin/bootstrap
