FROM zookeeper:3.7.0

LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

# ZOO_CONF_DIR=/conf
VOLUME ["/data", "/datalog", "/logs"]

EXPOSE 2181 2888 3888 8080

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["zkServer.sh", "start-foreground"]
