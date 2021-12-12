FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:3.7

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

ADD build.sh /tmp/build.sh

# RUN apk add --no-cache bash && bash /tmp/build.sh
RUN sh /tmp/build.sh && rm -fr /tmp/* && rm -fr /tmp/.build

WORKDIR /app
EXPOSE 9000
CMD ["php-fpm","--nodaemonize"]
