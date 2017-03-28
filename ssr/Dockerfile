FROM alpine:latest
MAINTAINER imxieke <imxieke@qq.com>
RUN set -ex \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr/shadowsocksr/archive/manyuser.zip

#ADD run.sh /run.sh
#RUN chmod +x /run.sh
CMD /usr/bin/ssserver -p ${PORT} -k ${PASSWD}  -O auth_sha1_v4 -o tls1.2_ticket_auth --user nobody -d start