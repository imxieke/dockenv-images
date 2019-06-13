#!/bin/bash

if [ -f /.root_pw_set ]; then
	echo "Root password already set!"
	exit 0
fi

if [ "${USERNAME}" == "" ]; then
	USERNAME="ubuntu"
fi

if [ "${PASSWORD}" == "" ]; then
	PASSWORD=$(pwgen -s 12 1)
fi

if [ "${USERNAME}" != "root" ]; then
	echo "######### Config User ENV ##############"
	useradd -d /home/${USERNAME} -m ${USERNAME} -s /bin/bash
	echo "${USERNAME}:${PASSWORD}" | chpasswd
fi

echo "=> Setting ${USERNAME} password for the root user"
echo "root:$PASSWORD" | chpasswd
echo "=> Done!"
touch /.root_pw_set
echo "========================================================================"
echo "You can now connect to this Ubuntu container via SSH using:"
echo ""
echo "    ssh ${USERNAME}@<host> -p <port>"
echo "and enter the ${USERNAME} password '$PASSWORD' when prompted"
echo ""
echo "Please remember to change the above password as soon as possible!"
echo "========================================================================"
