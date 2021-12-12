FROM aerospike:ce-5.7.0.8
LABEL MAINTAINER="Cloudflying" \
        MAIL="oss@live.hk"

EXPOSE 3000 3001 3002

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/entrypoint.sh"]

CMD ["asd"]
