FROM ghcr.io/dockenv/debian:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

RUN apt update -y --fix-missing \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        curl \
        ca-certificates \
    && VERSION=$(curl -sX GET "https://api.github.com/repos/mozilla/geckodriver/releases/latest" | awk '/tag_name/{print $4;exit}' FS='[""]') \
    && wget -cq --no-check-certificate "https://github.com/mozilla/geckodriver/releases/download/${VERSION}/geckodriver-${VERSION}-linux64.tar.gz" -O /tmp/geckodriver.tar.gz \
    && tar -xvf /tmp/geckodriver.tar.gz -C /tmp \
    && mv /tmp/geckodriver /usr/bin/geckodriver \
    && chmod +x /usr/bin/geckodriver \
    && rm -fr /tmp/* \
    && apt purge wget curl ca-certificates -y \
    && apt autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && rm -fr /var/lib/apt/lists/*

EXPOSE 4444

CMD /usr/bin/geckodriver --log debug --host 127.0.0.1 --port 4444
