#!/bin/bash

# start up supervisord, all daemons should launched by supervisord.
#/usr/bin/supervisord -c /root/supervisord.conf

# Create System User
USER="arch"
PASS="archlinux"
useradd -d /home/$USER -m $USER -s /bin/bash
echo "$USER:$PASS" |chpasswd
echo "root:$PASS" | chpasswd
echo "$USER ALL=NOPASSWD: ALL" >>/etc/sudoers

## change vnc password
echo -e "\n------------------ change VNC password  ------------------"
# first entry is control, second is view (if only one is valid for both)
mkdir -p "$HOME/.vnc"
PASSWD_PATH="$HOME/.vnc/passwd"
if [[ $VNC_VIEW_ONLY == "true" ]]; then
    echo "start VNC server in VIEW ONLY mode!"
    #create random pw to prevent access
    echo $(head /dev/urandom | tr -dc A-Za-z0-9 | head -c 20) | vncpasswd -f > $PASSWD_PATH
fi

echo "$VNC_PW" | vncpasswd -f >> $PASSWD_PATH
chmod 600 $PASSWD_PATH

## start Desktop and vncserver, noVNC webclient
#$NO_VNC_HOME/utils/launch.sh --vnc $VNC_IP:$VNC_PORT --listen $NO_VNC_PORT &
vncserver -kill $DISPLAY || rm -rfv /tmp/.X*-lock /tmp/.X11-unix || echo "remove old vnc locks to be a reattachable container"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION
exec dbus-run-session startxfce4

VNC_IP=$(hostname -i)
# Print Log
echo "======================================================================"
echo -e "\n\n------------- VNC environment started -------------------------"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/?password=...\n"
echo "You can now connect to this container via SSH using:					"
echo "           ssh $USER@HOST -p port 				    				"
echo "Enter the $USER password '$PASS' when prompted						"
echo "Please remember to change the above password as soon as possible!		"
echo "======================================================================"
echo "				Archlinux Xfce4 is Running 						    	"
echo "======================================================================"

exec /usr/sbin/sshd -D
