#!/bin/sh
exec /usr/bin/ssserver -p ${PORT} -k ${PASSWD}  -O auth_sha1_v4 -o tls1.2_ticket_auth --user nobody -d start
echo "Passwd:"${PASSWD}
echo "port:"${PORT}
echo "enjoy it!"