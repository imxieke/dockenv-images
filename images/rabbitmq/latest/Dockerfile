FROM rabbitmq:alpine
LABEL MAINTAINER="Cloudflying" \
        MAIL="<oss@live.hk>"

RUN rabbitmq-plugins enable --offline rabbitmq_management

EXPOSE 4369 5671 5672 15691 15692 25672
