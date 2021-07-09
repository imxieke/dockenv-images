FROM alpine:3.13
LABEL MAINTAINER="Cloudflying" \
  MAIL="<oss@live.hk>"

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories \
	&& echo 'nameserver 223.5.5.5' > /etc/resolv.conf

CMD [ "/bin/sh" ]
