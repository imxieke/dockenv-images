FROM imxieke/alpine:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN apk add --no-cache nginx

EXPOSE 80 443
CMD ["nginx", "-g", "daemon off;"]