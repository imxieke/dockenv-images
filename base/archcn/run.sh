#!/bin/bash

PASS=${ROOT_PASS}
USER=${USERNAME}
useradd -d /home/$USERNAME -m $USERNAME -s /bin/bash
echo "$USERNAME:$PASS" |chpasswd
echo "root:$PASS" | chpasswd
echo "$USERNAME ALL=NOPASSWD: ALL" >>/etc/sudoers
echo "======================================================================"
echo "You can now connect to this container via SSH using:					"
echo "    ssh $USERNAME@host -p port 										"
echo "Enter the $USERNAME password '$PASS' when prompted					"
echo "Please remember to change the above password as soon as possible!		"
echo "======================================================================"

exec /usr/sbin/sshd -D
