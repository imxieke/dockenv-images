FROM aerospike:latest
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

COPY aerospike.conf /etc/aerospike/aerospike.conf

EXPOSE 3000 3001 3002

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]

CMD ["asd"]
