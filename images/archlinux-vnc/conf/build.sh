#!/usr/bin/env bash

pacman -S --noconfirm --force  xorg-server xorg-apps i3-wm zsh vim git wget net-tools bzip2 python python-pip python-numpy supervisor \
		xterm gettext
pip install websocket websocketproxy
echo '#!/bin/sh' > ${HOME}/.xinitrc
echo 'exec i3' >> ${HOME}/.xinitrc