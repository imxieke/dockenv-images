FROM mongo:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

USER mongodb

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 27017
CMD ["mongod"]
