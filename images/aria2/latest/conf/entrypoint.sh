#!/usr/bin/env sh
###
 # @Author: Cloudflying
 # @Date: 2021-09-19 01:25:54
 # @LastEditTime: 2022-07-14 17:36:57
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/aria2/latest/conf/entrypoint.sh
###
ARIA2_CONF='/etc/aria2c/aria2c.conf'
if [[ -z "${ARIA2_PORT}" ]]; then
    ARIA2_PORT=6800
fi

if [[ -z "${WEBUI_PORT}" ]]; then
    WEBUI_PORT=6801
fi

if [[ -z "${DHT_PORT}" ]]; then
    DHT_PORT='6802-6999'
fi

if [[ -z "${RPC_SECRET}" ]]; then
    RPC_SECRET='haspwd'
fi

sed -i "s/rpc-listen-port=.*/rpc-listen-port=${ARIA2_PORT}/g" ${ARIA2_CONF}
sed -i "s/rpc-secret=.*/rpc-secret=${RPC_SECRET}/g" ${ARIA2_CONF}
sed -i "s/dht-listen-port.*/dht-listen-port=${DHT_PORT}/g" ${ARIA2_CONF}

aria2c --conf-path=/etc/aria2c/aria2c.conf -D
darkhttpd /opt/ariang --port ${WEBUI_PORT} --daemon >>/dev/null
echo -e "
    Welcome to Aria2c Container is Running

Aria2 Port : 127.0.0.1:${ARIA2_PORT}
WEBUI Port : 127.0.0.1:${WEBUI_PORT}
RPC Secret : ${RPC_SECRET}

"
touch /var/log/aria2.log
tail -f /var/log/aria2.log
