FROM daocloud.io/xiekers/alpine:latest

LABEL MAINTAINER="Sky" \
        MAIL="Sky@gfw.party"

ENV GOPATH /go
ENV GOBIN ${GOPATH}/bin
ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:$GOBIN

RUN apk update && \
    apk add --no-cache go && \
    rm -fr /var/cache/apk/* && \
    mkdir -p "$GOPATH/src" "$GOPATH/bin" "${GOPATH}}/pkg" \
    && chmod -R 777 "$GOPATH" \
    && rm -fr /var/cache/apk/* \
    && rm -fr /tmp/*

WORKDIR $GOPATH
CMD [ "/bin/sh" ]
