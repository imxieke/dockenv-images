#latest ownCloud in Docker!
FROM imxieke/php:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV NAME nextcloud
RUN echo "==> Download NextCloud" \
		&& apt update -y \
		&& apt install -y wget unzip \
	  	&& cd /tmp \
	  	&& mkdir -p /tmp/${NAME}	\
	  	&& wget https://download.${NAME}.com/server/releases/latest.zip -O /tmp/${NAME}.zip \
        && rm -fr /var/www/* \
        && unzip /tmp/${NAME}.zip -d /tmp/${NAME}/ \
        && mv /tmp/${NAME}/* /var/www/ \
        && rm -fr /tmp/* \
        && chmod 755 -R /var/www/ \
        && chown www-data:www-data -R /var/www \
        && apt purge -y wget unzip \
        && apt autoremove -y \
		&& apt-get clean all \
		&& rm -fr /var/lib/apt/lists/*

EXPOSE 80
CMD /bin/start.sh