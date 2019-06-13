FROM imxieke/php:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

RUN echo "==> Download KodCloud " \
		&& apt update -y \
		&& apt install -y wget unzip \
	  	&& cd /tmp \
	  	&& wget http://static.kodcloud.com/update/download/kodexplorer4.32.zip -O KodExplorer.zip \
	  	&& rm -fr /var/www/* \
	  	&& unzip KodExplorer.zip -d /var/www/ \
	  	&& echo "==> Set Permision" \
	  	&& chmod -R 755 /var/www \
	  	&& chown -R www-data:www-data /var/www \
	  	&& rm -fr KodExplorer.zip \
	  	&& apt purge -y wget unzip \
	  	&& apt autoremove -y \
		&& apt-get clean all \
		&& rm -fr /var/lib/apt/lists/*

EXPOSE 80
CMD /bin/start.sh
