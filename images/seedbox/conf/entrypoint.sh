#!/usr/bin/env sh
ARIA2_CONF='/etc/aria2c/aria2c.conf'
if [[ -z "${ARIA2_PORT}" ]]; then
    ARIA2_PORT=6800
fi

if [[ -z "${WEBUI_PORT}" ]]; then
    WEBUI_PORT=6801
fi

if [[ -z "${DHT_PORT}" ]]; then
    DHT_PORT='6802:6999'
fi

if [[ -z "${RPC_SECRET}" ]]; then
    RPC_SECRET='haspwd'
fi

sed -i "s/ARIA2_PORT/${ARIA2_PORT}/g" ${ARIA2_CONF}
sed -i "s/RPC_SECRET/${RPC_SECRET}/g" ${ARIA2_CONF}
sed -i "s/DHT_PORT/${DHT_PORT}/g" ${ARIA2_CONF}

aria2c --conf-path=/etc/aria2c/aria2c.conf -D
darkhttpd /opt/ariang --port ${WEBUI_PORT} --daemon >>/dev/null
echo -e "
    Welcome to Aria2c Container is Running

Aria2 Port : 127.0.0.1:${ARIA2_PORT}
WEBUI Port : 127.0.0.1:${WEBUI_PORT}
RPC Secret : ${RPC_SECRET}

" > /tmp/welcome.log


tail -f /tmp/welcome.log
