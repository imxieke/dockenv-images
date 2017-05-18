FROM ubuntu:trusty
MAINTAINER imxieke <imxieke@qq.com>

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get install apache2 php php-mbstring php-gd php-curl php-odbc php-mysql git

RUN mkdir -p /var/www/html && \
	git clone https://github.com/kalcaddle/KODExplorer.git /var/www/html && \
	rm -fr /var/www/html/.git && \
	chmod 777 -R /var/www/html && \
	apt-get remove -y --purge git && \
	apt-get autoremove -y && \
	apt-get apt-get clean all && \
	rm -fr /var/lib/apt/lists/*

EXPOSE 80
CMD ['service','apache2','start']