#!/usr/bin/env sh

sed -i "s/6800/${ARIA2_PORT}/g" /etc/aria2c/aria2c.conf
sed -i "s/aria2pwd/${ARIA2_SECRET}/g" /etc/aria2c/aria2c.conf

aria2c --conf-path=/etc/aria2c/aria2c.conf -D
darkhttpd /data/ --port ${WEBUI_PORT}