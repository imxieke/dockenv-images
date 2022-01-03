FROM ghcr.io/dockenv/debian:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

RUN apt update -y --fix-missing \
    && apt-get install -y --no-install-recommends --no-install-suggests \
        wget \
        curl \
        unzip \
        ca-certificates \
    && wget -cq --no-check-certificate https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -O /tmp/chrome.deb \
    && apt-get install -y --no-install-recommends --no-install-suggests /tmp/chrome.deb \
    # Taobao Chromedriver mirror
    # curl -sL https://npm.taobao.org/mirrors/chromedriver/ | grep -v 'LATEST' | grep -v 'icons' | grep -v 'index.html' | grep mirrors | awk -F '>' '{print $2}' | awk -F '\/<' '{print $1}' | sort -h --reverse | head -n 1
    && VERSION=$(curl -sL https://chromedriver.storage.googleapis.com/LATEST_RELEASE) \
    && wget -cq --no-check-certificate "https://chromedriver.storage.googleapis.com/${VERSION}/chromedriver_linux64.zip" -O /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip \
    && mv chromedriver /usr/bin/chromedriver \
    && chmod +x /usr/bin/chromedriver \
    && rm -fr /tmp/* \
    && apt purge curl -y \
    && apt autoremove -y \
    && apt-get clean -y \
    && apt-get autoclean -y \
    && rm -fr /var/lib/apt/lists/*

EXPOSE 4444 4445

CMD /usr/bin/chromedriver --port=4444 --adb-port=4445 --allowed-origins=* --allowed-ips=
