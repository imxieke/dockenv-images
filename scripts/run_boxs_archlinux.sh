#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-12-06 23:20:17
 # @LastEditTime: 2021-12-07 00:35:20
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/scripts/run_boxs_archlinux.sh
###

docker run -d \
		--name archboxs \
		--hostname archboxs \
        --privileged \
        --tty \
        --interactive \
		-p 10022:22 \
		-p 10080:80 \
		-p 10443:443 \
		-p 15901:5901 \
		-p 16080:6080 \
		-p 16901:6901 \
		registry.cn-hongkong.aliyuncs.com/boxs/boxs:xfce-arch
