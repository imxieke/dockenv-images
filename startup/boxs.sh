#!/usr/bin/env bash

docker run -it --rm \
		--name boxs \
		--hostname boxs \
		-p 10022:22 \
		-p 10080:80 \
		-p 10443:443 \
		-p 16080:6080 \
		-p 15901:5901 \
		-p 16901:6901 \
		-v ~/Code:/data:rw \
		registry.cn-hongkong.aliyuncs.com/imxieke/boxs zsh