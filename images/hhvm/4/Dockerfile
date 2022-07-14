FROM ghcr.io/dockenv/ubuntu:20.04
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

RUN apt update -y \
    && echo "deb http://dl.hhvm.com/ubuntu focal main" > /etc/apt/sources.list.d/hhvm.list \
    && apt-get install -y --no-install-recommends curl gnupg \
    && curl -sL http://dl.hhvm.com/conf/hhvm.gpg.key | apt-key add - \
    && apt-get update -y \
    && apt-get install -y --no-install-recommends hhvm \
    && apt purge -y curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

CMD ['/bin/bash']
