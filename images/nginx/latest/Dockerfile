FROM ghcr.io/dockenv/alpine:3.16
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"
ENV HOME_DIR=/home/$USER


RUN apk add --no-cache nginx nginx-mod-http-brotli nginx-mod-http-cache-purge nginx-mod-http-dav-ext nginx-mod-http-geoip nginx-mod-http-geoip2 nginx-mod-http-js

EXPOSE 80

CMD /usr/sbin/nginx && /usr/bin/tail -f /var/log/nginx/*.log
