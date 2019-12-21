FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

ENV ARIA2_PORT=6880
ENV ARIA2_SECRET=aria2cpwd
ENV WEBUI_PORT=8080

RUN apk add --no-cache aria2 darkhttpd && \
	mkdir -p /etc/aria2c && \
	mkdir -p /data/downloads && \
	wget https://dev.tencent.com/u/imxieke/p/packages/git/raw/master/code/aria-webui/webui.zip -O /data/webui.zip && \
	unzip /data/webui.zip -d /data/ && \
	chmod 777 -R /data/ && \
	touch /etc/aria2c/aria2c.session

ADD conf/run.sh /data/run.sh
ADD conf/aria2c.conf /etc/aria2c/aria2c.conf

RUN chmod +x /data/*.sh && \
	chmod 777 -R /etc/aria2c/


VOLUME ["/data"] 
EXPOSE ${ARIA2_PORT}

CMD ["/data/run.sh"]