FROM registry.cn-hongkong.aliyuncs.com/imxieke/ubuntu:bionic

LABEL DEBIAN_FRONTEND noninteractive\
        MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD script/build.sh /tmp/build.sh
ADD script/tz.php /var/www/index.php
ADD conf/nginx.conf /etc/nginx/
ADD conf/default.conf /etc/nginx/conf.d/

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && chmod +x /tmp/build.sh \
    && bash /tmp/build.sh

EXPOSE 80 443
CMD /bin/phpenv