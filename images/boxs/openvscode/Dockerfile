FROM ghcr.io/dockenv/debian:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV LANG=en_US.UTF-8 \
    USER="boxs" \
	PASSWD="boxs"

ENV HOME_DIR=/home/$USER

ADD entrypoint.sh /usr/bin/entrypoint.sh

RUN sed -i 's#repo.huaweicloud.com#repo.huaweicloud.com#g' /etc/apt/sources.list\
    && apt update -y --fix-missing \
    && apt install -y --no-install-recommends \
        git \
        zsh \
        procps \
        net-tools \
        locales \
        htop \
        curl \
        wget \
        ca-certificates \
        sudo \
    && sed -i "s/# en_US.UTF-8/en_US.UTF-8/" /etc/locale.gen \
    && locale-gen \
    && useradd -d /home/${USER} -m -s /usr/bin/zsh ${USER} \
    && echo "${USER}:${PASSWD}" | chpasswd \
    && echo "root:${PASSWD}" | chpasswd \
    && git clone --depth 1 https://e.coding.net/pkgs/oh-my-zsh/oh-my-zsh.git ${HOME_DIR}/.oh-my-zsh \
    && cp ${HOME_DIR}/.oh-my-zsh/templates/zshrc.zsh-template ${HOME_DIR}/.zshrc \
    && sed -i 's/ZSH_THEME.*/ZSH_THEME="strug"/g' ${HOME_DIR}/.zshrc \
    && echo 'Asia/Shanghai' > /etc/timezone \
    && rm -fr /etc/localtime \
    && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && VERSION=$(curl -sX GET "https://api.github.com/repos/gitpod-io/openvscode-server/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]' | sed 's|^openvscode-server-v||') \
    && wget -c --no-check-certificate "https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-v${VERSION}/openvscode-server-v${VERSION}-linux-x64.tar.gz" -O /tmp/openvscode.tar.gz \
    && tar -xvf /tmp/openvscode.tar.gz -C /opt \
    && mv /opt/openvscode-server-v${VERSION}-linux-x64 /opt/openvscode \
    # && code-server --user-data-dir ${HOME_DIR}/.vscode --install-extension vscode-icons-team.vscode-icons \
    # && code-server --user-data-dir ${HOME_DIR}/.vscode --install-extension ms-vscode.sublime-keybindings \
    # && code-server --user-data-dir ${HOME_DIR}/.vscode --install-extension editorconfig.editorconfig \
    && chmod -R 755 ${HOME_DIR} \
    && chown -R boxs:boxs ${HOME_DIR} \
    && apt autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && rm -fr /var/lib/apt/lists/* \
    && chmod +x /usr/bin/entrypoint.sh

USER ${USER}
EXPOSE 3000
WORKDIR ${HOME_DIR}

CMD ["/usr/bin/entrypoint.sh"]
