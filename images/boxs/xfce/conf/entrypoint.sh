#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-10-19 14:13:26
 # @LastEditTime: 2021-10-25 14:13:21
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/xfce/conf/entrypoint.sh
###

HOST_IP=$(hostname -i)
# echo '==> start vncserver and noVNC webclient && dbus'
sudo /etc/init.d/dbus start > /dev/null

sudo chown -R ${USER}:${USER} ${HOME_DIR}
sudo chmod -R 755 ${HOME_DIR}
VNC_PASSWD_PATH="${HOME_DIR}/.vnc"
mkdir -p $VNC_PASSWD_PATH
echo "$VNC_PASSWD" | vncpasswd -f >> $VNC_PASSWD_PATH/passwd
chmod 600 $VNC_PASSWD_PATH/passwd
touch ${HOME_DIR}/.Xauthority

vncserver -kill $DISPLAY > /dev/null 2>&1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix
rm -fr /tmp/.X1*
/bin/vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry ${VNC_RESOLUTION} > /tmp/vncserver.log 2>&1 &

sudo /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf -l /var/log/supervisord.log -j /var/run/supervisord.pid

# 重置 SSH 端口
if [[ -n "${SSH_PORT}" ]]; then
    sudo sed -i "s/^Port.*/Port ${SSH_PORT}/g" /etc/ssh/sshd_config
    sudo service ssh restart > /dev/null
fi

echo "======================================================================"
echo "You can now connect to this container via SSH using:                  "
echo "    ssh ${USER}@${HOST_IP} -p ${SSH_PORT}                             "
echo "Enter the ${USER} password => '${PASSWD}' when prompted               "
echo "Please remember to change the above password as soon as possible!     "
echo "================Boxs VNC Config======================================="
echo "  VNC   Port     : ${VNC_PORT}                                        "
echo "  noVNC Port     : ${NO_VNC_PORT}                                     "
echo "  VNC   Password : ${VNC_PASSWD}                                      "
echo "======================================================================"
echo "                Boxs is Running                                       "
echo "======================================================================"
tail -f /etc/os-release > /dev/null
