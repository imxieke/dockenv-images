FROM imxieke/java:latest

LABEL MAINTAINER="Cloudflying" \
    MAIL="oss@live.hk"

ENV ELASTIC_VERSION 5.6.2

RUN apk update \
    && apk add --no-cache bash openrc elasticsearch nodejs nodejs-npm \
    && mkdir -p /opt && cd /tmp \
    && wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-${ELASTIC_VERSION}.tar.gz \
    && wget https://artifacts.elastic.co/downloads/kibana/kibana-${ELASTIC_VERSION}-linux-x86_64.tar.gz \
    && tar -xvf elasticsearch-${ELASTIC_VERSION}.tar.gz -C /opt/ \
    && tar -xvf kibana-${ELASTIC_VERSION}-linux-x86_64.tar.gz -C /opt/ \
    && ln -s /opt/elasticsearch-{ELASTIC_VERSION}/bin/* /bin \
    && ln -s /opt/kibana-${ELASTIC_VERSION}-linux-x86_64/bin/* /bin \
    && rm -fr /var/cache/apk/* \
    && rm -fr *.tar.gz \
    && rm -fr /opt//opt/elasticsearch-{ELASTIC_VERSION}/bin/*.exe \
    && rm -fr /opt//opt/elasticsearch-{ELASTIC_VERSION}/bin/*.bat

EXPOSE 9200 9300

CMD [ "/bin/sh" ]
