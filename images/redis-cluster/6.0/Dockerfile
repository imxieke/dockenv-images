FROM bitnami/redis-cluster:6.0

LABEL MAINTAINER="Cloudflying" \
    MAIL="<oss@live.hk>"

EXPOSE 6379

USER 1001
ENTRYPOINT [ "/opt/bitnami/scripts/redis-cluster/entrypoint.sh" ]
CMD [ "/opt/bitnami/scripts/redis-cluster/run.sh" ]
