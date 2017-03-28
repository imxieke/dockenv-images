#!/bin/sh
/usr/bin/ssserver -p ${port} -k ${passwd}  -O auth_sha1_v4 -o tls1.2_ticket_auth --user nobody -d start
echo "Passwd:"${passwd}
echo "port:"${port}
echo "enjoy it!"