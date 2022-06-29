FROM mariadb:10.6

LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv \
    org.opencontainers.image.description='Mariadb 10.6'

VOLUME /var/lib/mysql
ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 3306
CMD ["mariadbd"]
