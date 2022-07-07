#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-10-19 14:13:26
 # @LastEditTime: 2022-07-01 19:57:15
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/xfce/conf/entrypoint.sh
###

# Init User Env
[ -z "${USER}" ] && USER="boxs"
[ -z "${PASSWD}" ] && PASSWD="boxs"
[ -z "${HOME_DIR}" ] && HOME_DIR="/home/${USER}"

HOST_IP=$(hostname -i)
# echo '==> start vncserver and noVNC webclient && dbus'
sudo /etc/init.d/dbus start > /dev/null

VNC_PASSWD_PATH="${HOME_DIR}/.vnc"
mkdir -p $VNC_PASSWD_PATH
echo "$VNC_PASSWD" | vncpasswd -f >> $VNC_PASSWD_PATH/passwd
chmod 600 $VNC_PASSWD_PATH/passwd
touch ${HOME_DIR}/.Xauthority
chmod 644 ${HOME_DIR}/.Xauthority

# Pulse Audio

# vncserver -kill $DISPLAY > /dev/null 2>&1 || rm -rfv /tmp/.X*-lock /tmp/.X11-unix
# rm -fr /tmp/.X1*
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry ${VNC_RESOLUTION} -localhost no -autokill yes > /tmp/vncserver.log 2>&1 &

# 重置 SSH 端口
if [[ -n "${SSH_PORT}" ]]; then
    sudo sed -i "s/^Port.*/Port ${SSH_PORT}/g" /etc/ssh/sshd_config
    # sudo service ssh restart > /dev/null
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
# sudo /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf -l /var/log/supervisord.log -j /var/run/supervisord.pid -n
sudo /usr/bin/supervisord -c /etc/supervisor/supervisord.conf -n
