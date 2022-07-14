FROM mysql:8
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='MYSQL Latest'

VOLUME /var/lib/mysql

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

CMD ["mysqld"]
