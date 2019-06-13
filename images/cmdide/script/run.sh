#!/bin/bash

#RUN_MODE local remote

if [[ ${USER} == "" ]]; then
	USER="cmdide"
fi

if [[ ${PASSWD} = "" ]]; then
	PASSWD="cmdide"
fi

if [[ ${USER} != "cmdide" ]]; then
	useradd -d /home/${USER} -m -s /bin/zsh ${USER}
    echo "${USER}:${PASSWD}" | chpasswd
    echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" >> /etc/sudoers
    chmod -R 755 $HOME_DIR
    chown -R ${USER}:${USER} $HOME_DIR
fi

if [[ ${RUN_MODE} == "" || ${RUN_MODE} == "local" ]]; then
	exit 0
fi

if [[ ${RUN_MODE} == "remote" ]]; then
	echo "======================================================================"
	echo "You can now connect to this container via SSH using:					"
	echo "    ssh ${USER}@HOST -p port 											"
	echo "Enter the ${USER} password => '${PASSWD}' when prompted				"
	echo "Please remember to change the above password as soon as possible!		"
	echo "======================================================================"
	echo "		Cmdide is Running 												"
	echo "======================================================================"
	exec sudo /usr/sbin/sshd -D -e
fi
