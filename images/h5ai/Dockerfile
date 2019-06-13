FROM imxieke/php:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

RUN echo "==> Download h5ai " \
		&& apt update -y \
		&& apt install -y wget unzip \
		&& wget https://release.larsjung.de/h5ai/h5ai-0.29.0.zip -O /tmp/h5ai.zip \
		&& rm -fr /var/www/* \
		&& rm -fr /etc/nginx/conf.d/* \
		&& unzip /tmp/h5ai.zip -d /var/www \
	  	&& echo "==> Set Permision" \
	  	&& chmod -R 755 /var/www \
	  	&& chown -R www-data:www-data /var/www \
	  	&& rm -fr /tmp/h5ai.zip \
	  	&& apt purge -y wget unzip \
	  	&& apt autoremove -y \
		&& apt-get clean all \
		&& rm -fr /var/lib/apt/lists/*

ADD default.conf /etc/nginx/conf.d/
EXPOSE 80
CMD /bin/start.sh