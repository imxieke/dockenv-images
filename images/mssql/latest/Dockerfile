FROM mcr.microsoft.com/mssql/server:latest

LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='MSSQL'

ENV ACCEPT_EULA=Y
VOLUME /var/opt/mssql

EXPOSE 1433
CMD /opt/mssql/bin/sqlservr
