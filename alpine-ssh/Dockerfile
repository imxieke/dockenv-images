FROM alpine:edge
MAINTAINER imxieke <imxieke@qq.com>

# make sure the package repository is up to date
RUN apk update && apk upgrade
# install dropbear as the sshd byobu tmux
RUN apk add openssh openssh-sftp-server && \
    /bin/sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    /bin/sed -i -e 's/#PermitUserEnvironment no/PermitUserEnvironment yes/' /etc/ssh/sshd_config && \
    mkdir -p /root/.ssh && \
    chmod 700 /root/.ssh && \
    /usr/bin/ssh-keygen -A && \
    echo "source /etc/profile.d/color_prompt" > /root/.bashrc

ADD sshd.sh /
RUN chmod +x /*.sh

# expose ports for ssh
EXPOSE 22
CMD    ["/sshd.sh"]

