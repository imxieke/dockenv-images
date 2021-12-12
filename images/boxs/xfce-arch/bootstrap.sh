#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-10-25 17:32:09
 # @LastEditTime: 2021-12-06 22:47:35
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/images/boxs/xfce-arch/bootstrap.sh
###

mkdir -p ~/.vnc
echo 'boxsvnc' | vncpasswd -f > ~/.vnc/passwd
chmod 600 ~/.vnc/passwd

/usr/bin/vncserver :1 > /tmp/vnc.log 2>&1 &
dbus-launch /usr/bin/xfce4-session --display=:1 > /tmp/xfce4-session.log 2>&1 &
# dbus-launch /usr/bin/startxfce4
xfwm4
xfsettingsd
xfdesktop
xfce4-session
wrapper-2.0:149

# yelp yelp-xsl zenity pavucontrol x11vnc
    # multimedia Pic Viewer
    # inkscape vector-based drawing program
    # apt install -y --no-install-recommends nomacs smplayer inkscape \
    # Twin panel file management for your desktop
    # kdiff3 kcompare arj unarj
    # && apt install -y --no-install-recommends krusader krename  \
