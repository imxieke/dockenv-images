FROM mariadb:10.5

LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='Mariadb 10.5'

VOLUME /var/lib/mysql
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3306
CMD ["mariadbd"]
