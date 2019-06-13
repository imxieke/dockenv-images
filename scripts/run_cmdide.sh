#!/usr/bin/env bash

docker run -d \
		--name cmdide \
		--hostname cmdide \
		-p 30022:22 \
		-p 30080:80 \
		-e RUN_MODE="remote" \
		-v /Volumes/MacData/Code:/data:rw \
		-v /Volumes/MacData/Code/Devenv/Volumes/nginx:/etc/nginx/conf:rw \
		imxieke/cmdide:latest
