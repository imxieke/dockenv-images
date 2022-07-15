FROM mongo:5.0
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

VOLUME /data/db /data/configdb
ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
