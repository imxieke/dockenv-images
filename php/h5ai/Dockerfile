# h5ai 0.28.1 in-line file directory
FROM debian:jessie
MAINTAINER Xiekers <im@xieke.org>

ENV NGINX_VERSION 1.10.0-1~jessie
RUN echo "deb http://nginx.org/packages/debian/ jessie nginx" >> /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get install --no-install-recommends --no-install-suggests -y \
						ca-certificates \
						nginx=${NGINX_VERSION} \
						nginx-module-xslt \
						nginx-module-geoip \
						nginx-module-image-filter \
						nginx-module-perl \
						nginx-module-njs \
						gettext-base \
	&& rm -rf /var/lib/apt/lists/*

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log
RUN ls /etc/nginx/conf.d && mv /etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf.bak
ADD https://coding.net/u/imxieke/p/Tools/git/raw/master/h5ai.conf /etc/nginx/conf.d/default.conf

WORKDIR /var/www/html
ADD h5ai-0.28.1.zip /var/www/html

RUN chmod 777 -R /var/www/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]