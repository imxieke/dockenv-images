#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-12-15 17:29:39
 # @LastEditTime: 2021-12-15 17:47:46
 # @LastEditors: Cloudflying
 # @Description:gogs run script
 # @FilePath: /dockenv/scripts/run_gogs.sh
###

docker run \
    --rm \
    --name gogs \
    --hostname gogs \
    -p 10022:22 \
    -p 13000:3000 \
    -v $(pwd)/runtime/data/gogs:/data \
    gogs/gogs:latest

