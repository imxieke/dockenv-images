FROM registry.cn-hongkong.aliyuncs.com/imxieke/ubuntu:16.04
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

RUN apt update -y \
    && apt-get install -y --no-install-recommends curl \
    && curl -sL http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - \
    && echo "deb http://dl.hhvm.com/ubuntu xenial-lts-3.30 main" > /etc/apt/sources.list.d/hhvm.list \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends hhvm \
    && apt purge -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ['/bin/bash']
