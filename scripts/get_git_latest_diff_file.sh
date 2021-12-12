#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2021-12-12 15:57:31
 # @LastEditTime: 2021-12-12 16:03:37
 # @LastEditors: Cloudflying
 # @Description:get git latest commit diff file
 # @FilePath: /dockenv/scripts/get_git_latest_diff_file.sh
###
COMMIT_NEW=$(git log | grep 'commit' | awk -F ' ' '{print $2}' | head -n 2 | tail -n +1 | head -n 1)
COMMIT_OLD=$(git log | grep 'commit' | awk -F ' ' '{print $2}' | head -n 2 | tail -n +2 | head -n 1)
echo "${COMMIT_NEW}" "${COMMIT_OLD}"
git diff --name-only "${COMMIT_NEW}" "${COMMIT_OLD}" | grep images | grep Dockerfile
# echo "git diff --name-only ${COMMIT_NEW} ${COMMIT_OLD}"
