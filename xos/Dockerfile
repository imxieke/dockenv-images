# Xiekers ToolKit Base Kali (for china)
FROM  registry.cn-hangzhou.aliyuncs.com/imxieke/kali:latest
MAINTAINER imxieke <imxieke@qq.com>

#Install Tools
RUN echo "deb http://mirrors.ustc.edu.cn/kali kali-rolling main non-free contrib" > /etc/apt/sources.list && \
    echo "deb-src http://mirrors.ustc.edu.cn/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && apt upgrade -y && DEBIAN_FRONTEND=noninteractive && apt-get -y install \
    openssh-server pwgen curl unzip wget zsh vim git apt-utils apt-transport-https ca-certificates && \
    apt-get clean all && rm -fr /var/lib/apt/lists/*

#Config ssh
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config

# Config User ENV
RUN useradd -d /home/imxieke -m imxieke -s /bin/zsh && echo "imxieke:imxieke" | chpasswd && \
    mkdir -p /home/imxieke/tmp &&  \
    git clone https://git.oschina.net/imxieke/oh-my-zsh.git /home/imxieke/.oh-my-zsh && \
    cp /home/imxieke/.oh-my-zsh/templates/zshrc.zsh-template /home/imxieke/.zshrc

#Clearn Environment
RUN apt-get autoremove -y --purge && apt-get clean all && rm -r /var/lib/apt/lists/*

ADD set_root_pw.sh /set_root_pw.sh
ADD tools.sh /home/imxieke/tmp/tools.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**

EXPOSE 22 80 666 5000 7681
CMD ["/run.sh"]