FROM ghcr.io/dockenv/ubuntu:22.04
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ADD https://github.com/krallin/tini/releases/download/v0.19.0/tini-amd64 /usr/bin/tini

RUN chmod +x /usr/bin/tini

CMD ["bash"]
