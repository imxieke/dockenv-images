#!/bin/sh
sed -i "s#PORT#${PORT}#g" /tmp/shadowsocks.json
sed -i "s#PASSWD#${PASSWD}#g" /tmp/shadowsocks.json
sed -i "s#METHOD#${METHOD}#g" /tmp/shadowsocks.json
exec ss-server -c /tmp/shadowsocks.json -u
