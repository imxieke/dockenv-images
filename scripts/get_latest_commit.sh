#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-12-12 15:46:37
 # @LastEditTime: 2021-12-12 15:46:37
 # @LastEditors: Cloudflying
 # @Description: get git latest commit id
 # @FilePath: /dockenv/scripts/get_latest_commit.sh
###

[ ! -d .git ] && echo ".git dir is not found" && exit

git log | grep 'commit' | head -n 2 | awk -F ' ' '{print $2}'
