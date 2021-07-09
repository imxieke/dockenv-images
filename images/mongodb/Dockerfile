FROM registry.cn-hongkong.aliyuncs.com/imxieke/alpine:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN apk add --no-cache mongodb \
	&& mkdir -p /data/db /data/configdb \
	&& chown -R mongodb:mongodb /data/db /data/configdb

USER mongodb

VOLUME /data/db /data/configdb

# 28017 Monitor Page
EXPOSE 27017 28017

CMD [ "mongod", "--bind_ip", "0.0.0.0" ]