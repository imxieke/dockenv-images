#!/bin/bash

USER="devenv"
PASS="devenv"
useradd -d /home/$USER -m $USER -s /bin/bash
echo "$USER:$PASS" |chpasswd
echo "root:$PASS" | chpasswd
echo "$USER ALL=NOPASSWD: ALL" >>/etc/sudoers
echo "======================================================================"
echo "You can now connect to this container via SSH using:					"
echo "    ssh $USER@HOST -p port 											"
echo "Enter the $USER password '$PASS' when prompted						"
echo "Please remember to change the above password as soon as possible!		"
echo "======================================================================"
echo "				Devenv is Running 							"
echo "======================================================================"

exec /usr/sbin/sshd -D -e