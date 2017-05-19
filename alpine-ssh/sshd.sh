#!/bin/bash
if [[ $PASSWORD == "" ]]; then
	PASSWORD="alpine"
fi
echo "root:$PASSWORD" | chpasswd \
&& set | grep -i '^http_proxy\|^https_proxy\|^no_proxy' > /root/.ssh/environment \
&& echo "Username:root; Password: $PASSWORD" \
&& /usr/sbin/sshd -D -e