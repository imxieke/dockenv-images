FROM mysql:8.0
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

VOLUME /var/lib/mysql

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306

CMD ["mysqld"]
