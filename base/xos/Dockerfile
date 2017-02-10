# Xiekers ToolKit Base Kali (for china)
FROM daocloud.io/imxieke/kali
MAINTAINER Xiekers <imxieke@qq.com>
#Install Tools
RUN echo "deb http://http.kali.org/kali kali-rolling main contrib non-free" > /etc/apt/sources.list && \
    echo "deb-src http://http.kali.org/kali kali-rolling main contrib non-free" >> /etc/apt/sources.list && \
    apt-get update && apt upgrade -y && apt-get -y dist-upgrade && DEBIAN_FRONTEND=noninteractive &&  \
    apt-get -y install openssh-server pwgen gcc make automake autoconf fakeroot pkg-config build-essential g++ \
    apache2 php php-mbstring php-gd php-curl php-odbc php-mysql nodejs npm python  python-pip ruby \
    curl unzip screen zsh vim git htop nmap sqlmap apt-utils fping apt-transport-https ca-certificates && \
    apt-get autoremove -y --purge && apt-get clean all && rm -r /var/lib/apt/lists/*
# Install oh-my-zsh
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh \
    && cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
#Config ssh
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config && \
    sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh
ENV AUTHORIZED_KEYS **None**
ENV PAAS_ROOT password
EXPOSE 22 80 443 666 3306 5000
CMD ["/run.sh"]
