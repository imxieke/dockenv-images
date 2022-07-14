FROM openresty/openresty:alpine
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk" \
        org.opencontainers.image.source=https://github.com/dockenv/dockenv

STOPSIGNAL SIGQUIT
CMD ["/usr/local/openresty/bin/openresty", "-g", "daemon off;"]
