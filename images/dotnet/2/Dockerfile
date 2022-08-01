FROM ghcr.io/dockenv/ubuntu:22.04

LABEL MAINTAINER="Cloudflying" \
  MAIL="oss@live.hk" \
  org.opencontainers.image.source=https://github.com/dockenv/dockenv

RUN apt update -y \
    && apt install -y --no-install-recommends wget ca-certificates openssl \
    && wget --no-check-certificate https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O dotnet.deb \
    && dpkg -i dotnet.deb \
    && rm -fr dotnet.deb \
    && apt update -y \
    && apt install -y --no-install-recommends dotnet-sdk-2.1 \
    && apt purge -y wget \
    && apt autoremove -y \
    && apt-get clean all \
    && rm -fr /var/lib/apt/lists/*
