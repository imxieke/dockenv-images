FROM redis:5.0.14-alpine
LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>"

USER redis

VOLUME /data
WORKDIR /data

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 6379
CMD ["redis-server"]
