#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-12-06 23:20:17
 # @LastEditTime: 2021-12-07 00:34:51
 # @LastEditors: Cloudflying
 # @Description:
 # @FilePath: /dockenv/scripts/run_boxs_ubuntu.sh
###

docker run -d \
		--name ubunboxs \
		--hostname ubunboxs \
        --privileged \
        --tty \
        --interactive \
		-p 20022:22 \
		-p 20080:80 \
		-p 20443:443 \
		-p 25901:5901 \
		-p 26080:6080 \
		-p 26901:6901 \
		registry.cn-hongkong.aliyuncs.com/boxs/boxs:xfce
