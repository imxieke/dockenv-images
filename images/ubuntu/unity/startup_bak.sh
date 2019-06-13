#!/bin/bash

if [ ! -f $HOME/.vnc/passwd ] ; then

    if  [ -z "$PASSWORD" ] ; then
        PASSWORD=`pwgen -c -n -1 12`
        echo -e "PASSWORD = $PASSWORD" > $HOME/password.txt
    fi

    echo "$USER:$PASSWORD" | chpasswd

    # Set up vncserver
    su $USER -c "mkdir $HOME/.vnc && echo '$PASSWORD' | vncpasswd -f > $HOME/.vnc/passwd && chmod 600 $HOME/.vnc/passwd && touch $HOME/.Xresources"
    chown -R $USER:$USER $HOME

    if [ ! -z "$SUDO" ]; then
        case "$SUDO" in
            [yY]|[yY][eE][sS])
                adduser $USER sudo
        esac
    fi
else
    VNC_PID=`find $HOME/.vnc -name '*.pid'`
    if [ ! -z "$VNC_PID" ] ; then
        vncserver -kill :1
        rm -rf /tmp/.X1*
    fi
fi

# if [ ! -z "$NGROK" ] ; then
#         case "$NGROK" in
#             [yY]|[yY][eE][sS])
#                 su ubuntu -c "$HOME/ngrok/ngrok http 6080 --log $HOME/ngrok/ngrok.log --log-format json" &
#                 sleep 5
#                 NGROK_URL=`curl -s http://127.0.0.1:4040/status | grep -P "http://.*?ngrok.io" -oh`
#                 su ubuntu -c "echo -e 'Ngrok URL = $NGROK_URL/vnc.html' > $HOME/ngrok/Ngrok_URL.txt"
#         esac
# fi

source $HOME/.bashrc
# /usr/bin/supervisord -n
echo -e "=>Start vncserver with param: VNC_COL_DEPTH=$VNC_COL_DEPTH, VNC_RESOLUTION=$VNC_RESOLUTION"
vncserver $DISPLAY -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION &> /tmp/no_vnc_startup.log &
${NO_VNC_HOME}/utils/launch.sh --vnc localhost:${VNC_PORT} --listen $NO_VNC_PORT >/tmp/novnc.log &
${HOME}/.xsession > /tmp/xsession.log &

## log connect options
echo -e "\n\n=>VNC environment started"
echo -e "\nVNCSERVER started on DISPLAY= $DISPLAY \n\t=> connect via VNC viewer with $VNC_IP:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://$VNC_IP:$NO_VNC_PORT/?password=${VNC_PW}\n"


if [[ $DEBUG == true ]] || [[ $1 =~ -t|--tail-log ]]; then
    echo -e "\n=> $HOME/.vnc/*$DISPLAY.log "
    # if option `-t` or `--tail-log` block the execution and tail the VNC log
    tail -f /tmp/*.log $HOME/.vnc/*$DISPLAY.log
fi

if [ -z "$1" ] || [[ $1 =~ -w|--wait ]]; then
    wait $PID_SUB
else
    # unknown option ==> call command
    echo -e "\n\n=> EXECUTE COMMAND"
    echo "Executing command: '$@'"
    exec "$@"
fi
