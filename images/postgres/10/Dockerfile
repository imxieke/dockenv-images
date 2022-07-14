FROM postgres:10-alpine
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

VOLUME /var/lib/postgresql/data

ENTRYPOINT ["docker-entrypoint.sh"]
STOPSIGNAL SIGINT
EXPOSE 5432
CMD ["postgres"]
