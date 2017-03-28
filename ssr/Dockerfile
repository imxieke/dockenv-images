FROM alpine:latest
MAINTAINER imxieke <imxieke@qq.com>
ENV port
RUN set -ex \
    && apk --update add --no-cache libsodium py-pip \
    && pip --no-cache-dir install https://github.com/shadowsocksr/shadowsocksr/archive/manyuser.zip

ADD run.sh /run.sh
RUN chmod +x /run.sh
EXPOSE ${port}
ENTRYPOINT ["/run.sh"]