FROM mysql:5.6
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

VOLUME /var/lib/mysql

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3306 33060

CMD ["mysqld"]
