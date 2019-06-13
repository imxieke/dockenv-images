FROM imxieke/ubuntu:bionic

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD script/env.sh /bin/env.sh
ADD script/start.sh /bin/start.sh
ADD conf.d/index.php /var/www/
RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list \
    && chmod +x /bin/env.sh \
    && chmod +x /bin/start.sh \
    && bash /bin/env.sh

ADD conf.d/*.example /etc/nginx/conf.d/
EXPOSE 80 443
CMD /bin/start.sh