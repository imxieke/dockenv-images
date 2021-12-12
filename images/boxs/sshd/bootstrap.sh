#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-10-18 18:07:30
 # @LastEditTime: 2021-10-18 19:15:37
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/sshd/bootstrap.sh
###

# Change default password when -e PASSWD is set , default is ${PASWD}

if [[ -n "${PASSWD}" ]]; then
    echo "boxs:${PASSWD}" | sudo chpasswd
    echo "root:${PASSWD}" | sudo chpasswd
fi

echo "======================================================================" > /tmp/.boxs.run.log
echo "You can now connect to this container via SSH using:                  " >> /tmp/.boxs.run.log
echo "    ssh ${USER}@HOST -p port                                          " >> /tmp/.boxs.run.log
echo "Enter the ${USER} password => '${PASSWD}' when prompted               " >> /tmp/.boxs.run.log
echo "Please remember to change the above password as soon as possible!     " >> /tmp/.boxs.run.log
echo "======================================================================" >> /tmp/.boxs.run.log
echo "                  Boxs ssh is Running                                 " >> /tmp/.boxs.run.log
echo "======================================================================" >> /tmp/.boxs.run.log
sudo service ssh start > /dev/null
tail -f /tmp/.boxs.run.log
