FROM alpine:edge
LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

RUN apk add --no-cache beanstalkd

EXPOSE 11300
# /etc/aerospike/aerospike.conf
ENTRYPOINT ["/usr/bin/beanstalkd"]