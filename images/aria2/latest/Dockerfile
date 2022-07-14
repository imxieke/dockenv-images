FROM ghcr.io/dockenv/alpine:edge
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

COPY conf/ /etc/aria2c/

RUN sed -i 's/dl-cdn.alpinelinux.org/repo.huaweicloud.com/g' /etc/apk/repositories \
    && apk add --no-cache darkhttpd aria2 \
    && mkdir -p /etc/aria2c \
    && chmod -R 777 /etc/aria2c \
    && mkdir -p /opt/ariang \
    && chmod -R 777 /opt/ariang \
    && cd /opt/ariang \
    && wget https://github.com/mayswind/AriaNg/releases/download/1.2.4/AriaNg-1.2.4-AllInOne.zip \
    && unzip AriaNg-1.2.4-AllInOne.zip && rm -fr LICENSE && rm -fr AriaNg-1.2.4-AllInOne.zip \
    && mv /etc/aria2c/entrypoint.sh /usr/bin/entrypoint.sh \
    && chmod +x /usr/bin/entrypoint.sh

# 6080 Aria2
# 6081 Aria2 WebUI
EXPOSE 6080 6081

CMD ["/usr/bin/entrypoint.sh"]
