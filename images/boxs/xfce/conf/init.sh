#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2022-07-01 20:05:12
 # @LastEditTime: 2022-07-05 17:57:12
 # @LastEditors: Cloudflying
 # @Description: init System
 # @FilePath: /dockenv/images/boxs/xfce/conf/init.sh
###

# short package install command
apt_add()
{
    apt-get install -y --no-install-recommends --no-install-suggests $@
}

# System Base Package
apt install -y lsb-release ca-certificates apt-transport-https software-properties-common apt-utils

# systemd
apt install -y systemd init

# for compile
pkg_add build-essential

# Secret
pkg_add gnupg2

# crontab and service manager
pkg_add cron supervisor

pkg_add python3 python3-pip

# for neovim
pip install pynvim pyright
pip install jedi==0.18.0

pkg_add nodejs npm

