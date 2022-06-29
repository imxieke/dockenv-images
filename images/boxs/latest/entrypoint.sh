#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2022-06-25 00:21:46
 # @LastEditTime: 2022-06-25 00:21:46
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/latest/entrypoint.sh
###
#!/usr/bin/env bash

# Change default password when -e PASSWD is set , default is ${PASWD}

if [[ -n "${PASSWD}" ]]; then
    echo "boxs:${PASSWD}" | sudo chpasswd
    echo "root:${PASSWD}" | sudo chpasswd
fi

HOST_IP=$(hostname -i)

echo "======================================================================" > /tmp/.boxs.run.log
echo "You can now connect to this container via SSH using:                  " >> /tmp/.boxs.run.log
echo "    ssh ${USER}@${HOST_IP} -p port                                    " >> /tmp/.boxs.run.log
echo "Enter the ${USER} password => '${PASSWD}' when prompted               " >> /tmp/.boxs.run.log
echo "Please remember to change the above password as soon as possible!     " >> /tmp/.boxs.run.log
echo "======================================================================" >> /tmp/.boxs.run.log
echo "                  Boxs ssh is Running                                 " >> /tmp/.boxs.run.log
echo "======================================================================" >> /tmp/.boxs.run.log
sudo service ssh start > /dev/null
tail -f /tmp/.boxs.run.log
