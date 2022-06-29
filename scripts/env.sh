#!/usr/bin/env bash

###
 # @Author: Cloudflying
 # @Date: 2021-09-19 01:25:54
 # @LastEditTime: 2022-06-27 17:11:39
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/scripts/env.sh
###

PASSWORD=$(echo -n ${RANDOM} | md5sum | cut -b -12)
cpuNum=$(grep -c 'processor' /proc/cpuinfo)
