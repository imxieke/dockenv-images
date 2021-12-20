FROM alpine:3.12
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

COPY conf/ /etc/aria2c/

RUN sed -i 's/dl-cdn.alpinelinux.org/repo.huaweicloud.com/g' /etc/apk/repositories \
    && echo 'nameserver 8.8.8.8' > /etc/resolv.conf \
    && apk add --no-cache --virtual .deps curl \
    && apk add --no-cache darkhttpd \
    && curl -L https://cloudflying-generic.pkg.coding.net/storage/mirrors/pkgs/aria2/aria2c-amd64 -o /usr/bin/aria2c \
    && chmod +x /usr/bin/aria2c \
    && mkdir -p /etc/aria2c \
    && chmod -R 777 /etc/aria2c \
    && mkdir -p /opt/ariang \
    && chmod -R 777 /opt/ariang \
	  && mkdir -p /data/downloads \
    && chmod -R 777 /data/downloads \
    && cd /opt/ariang \
    && curl -L https://cloudflying-generic.pkg.coding.net/storage/mirrors/src/ariang/1.17.zip -o /opt/ariang/1.17.zip \
    && unzip 1.17.zip && rm -fr LICENSE && rm -fr 1.17.zip \
    && mv /etc/aria2c/entrypoint.sh /usr/bin/entrypoint.sh \
    && chmod +x /usr/bin/entrypoint.sh \
    && apk del .deps

CMD ["/usr/bin/entrypoint.sh"]
