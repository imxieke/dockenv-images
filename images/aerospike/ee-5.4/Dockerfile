FROM aerospike:ee-5.4.0.11
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

EXPOSE 3000 3001 3002

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]

CMD ["asd"]
