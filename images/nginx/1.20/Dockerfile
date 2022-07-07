FROM ghcr.io/dockenv/alpine:3.14

LABEL MAINTAINER="Cloudflying" \
  MAIL="<oss@live.hk>"

RUN apk add --no-cache nginx nginx-mod-http-brotli nginx-mod-http-dav-ext nginx-mod-stream nginx-mod-http-geoip \
        nginx-mod-http-geoip2 nginx-mod-http-headers-more nginx-mod-http-js nginx-mod-http-naxsi nginx-mod-http-nchan \
        nginx-mod-http-xslt-filter nginx-mod-mail nginx-mod-http-upstream-fair nginx-mod-http-image-filter nginx-mod-stream-geoip \
        nginx-mod-stream-geoip2 nginx-mod-stream-js

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]
