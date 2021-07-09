FROM alpine:3.7
LABEL MAINTAINER="Cloudflying" \
  MAIL="<oss@live.hk>"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
  && echo 'nameserver 8.8.8.8' > /etc/resolv.conf

CMD [ "/bin/sh" ]
