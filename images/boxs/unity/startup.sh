#!/bin/bash

echo "=> Set vnc password"
if [ ! -f $HOME/.vnc/passwd ] ; then
    echo "$USER:$PASSWD" | chpasswd
    # Set up vncserver
    su $USER -c "mkdir $HOME/.vnc
    echo '$PASSWD' | vncpasswd -f > $HOME/.vnc/passwd
    chmod 600 $HOME/.vnc/passwd && touch $HOME/.Xresources"
    chown -R $USER:$USER $HOME
else
    VNC_PID=`find $HOME/.vnc -name '*.pid'`
    if [ ! -z "$VNC_PID" ] ; then
        vncserver -kill :1
        rm -rf /tmp/.X1*
    fi
fi

/usr/bin/supervisord -n

# Supervisord sometimes don't working
unity > /tmp/unity.log &
