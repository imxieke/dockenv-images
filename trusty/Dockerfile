FROM ubuntu:trusty
MAINTAINER imxieke <imxieke@qq.com>

RUN apt-get update -y && apt-get upgrade -y && \
	apt-get autoremove -y && \
	apt-get clean all && \
	rm -fr /var/lib/apt/lists/*

CMD ['bash']