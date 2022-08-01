FROM gitea/gitea:dev
LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk" \
    org.opencontainers.image.source=https://github.com/dockenv/dockenv

VOLUME ["/data"]

EXPOSE 22 3000

ENTRYPOINT ["/usr/bin/entrypoint"]
CMD ["/bin/s6-svscan", "/etc/s6"]
