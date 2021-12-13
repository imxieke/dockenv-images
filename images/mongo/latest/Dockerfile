FROM mongo:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

# add our user and group first to make sure their IDs get assigned consistently, regardless of whatever dependencies get added
RUN apk add --no-cache mongodb \
	&& mkdir -p /data/db /data/configdb \
	&& chown -R mongodb:mongodb /data/db /data/configdb

USER mongodb

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
