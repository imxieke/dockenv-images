FROM imxieke/alpine:latest

LABEL MAINTAINER="Sky" \
        MAIL="Sky@gfw.party"

RUN apk update && \
    apk add --no-cache rsync && \
    rm -fr /var/cache/apk/*

CMD [ "/bin/sh" ]