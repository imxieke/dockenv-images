FROM nginx:1.18.0-alpine-perl
LABEL MAINTAINER="Cloudflying" \
  MAIL="<oss@live.hk>"

# 更改权限
RUN mkdir /var/www \
  && chown -R www-data.www-data /var/www/ /var/log/nginx/

# 设置时区 && 同步时间
ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# mount nginx log
VOLUME /var/log/nginx

WORKDIR /usr/share/nginx/html
EXPOSE 80 443 8080 8888 9090
CMD ["nginx", "-g", "daemon off;"]
