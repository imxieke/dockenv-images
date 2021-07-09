FROM mongo:latest
LABEL maintainer="Mahmoud Zalt <mahmoud@zalt.me>"

#COPY mongo.conf /usr/local/etc/mongo/mongo.conf

VOLUME /data/db /data/configdb

EXPOSE 27017
CMD ["mongod"]

FROM mongo:latest

