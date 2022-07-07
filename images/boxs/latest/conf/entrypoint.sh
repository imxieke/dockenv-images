#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2022-06-25 00:21:46
 # @LastEditTime: 2022-07-02 01:42:24
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/latest/conf/entrypoint.sh
###

# Change default password when -e PASSWD is set , default is ${DEFAULT_PASSWD}
HOME_DIR='/home/boxs'
DEFAULT_PASSWD=$(cat /dev/random | head -n 1 | sha256sum | head -c 12)

# Set Default Password If is empty will be set as ${DEFAULT_PASSWD}
if [[ -z "${USER_PASSWD}" ]]; then
    USER_PASSWD=${DEFAULT_PASSWD}
fi

if [[ -z "${IDE_PASSWD}" ]]; then
    IDE_PASSWD=${DEFAULT_PASSWD}
fi

# Reset User And Root Passwd
if [[ -n "${USER_PASSWD}" ]]; then
    echo "root:${USER_PASSWD}" | sudo chpasswd
    echo "boxs:${USER_PASSWD}" | sudo chpasswd
fi

# Reset SSH Port
if [[ -n "${SSH_PORT}" ]]; then
    sudo sed -i "s/^#Port.*/Port ${SSH_PORT}/g" /etc/ssh/sshd_config
fi

# Reset Code Server Password
if [[ -n "${IDE_PASSWD}" ]]; then
    sed -i "s#password:.*#password: ${IDE_PASSWD}#g" ${HOME_DIR}/.config/code-server/config.yaml
fi

if [[ -z "${IDE_PORT}" ]]; then
    sed -i "s#bind-addr:.*#bind-addr: 0.0.0.0:${IDE_PORT}#g" ${HOME_DIR}/.config/code-server/config.yaml
fi

HOST_IP=$(hostname -i)

echo "======================================================================"
echo "You can now connect to this container via SSH using:                  "
echo "    ssh ${RUN_USER}@${HOST_IP} -p ${SSH_PORT}                         "
echo "Enter the ${RUN_USER} password => ${USER_PASSWD} when prompted        "
echo "Please remember to change the above password as soon as possible!     "
echo "======================================================================"
echo "                  Boxs ssh is Running                                 "
echo "======================================================================"
sudo /usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
