#!/usr/bin/env bash
###
 # @Author: Cloudflying
 # @Date: 2022-07-15 21:35:07
 # @LastEditTime: 2022-07-15 21:43:40
 # @LastEditors: Cloudflying
 # @Description: fetch Package Latest Version and Update Dockerfile
 # @FilePath: /dockenv/scripts/updater.sh
###

# logstash elestic kibana
_logstash()
{
    api="https://hub.docker.com/v2/repositories/library/logstash/tags/?page_size=25&page=1"
    info=$(curl -sL ${api})
    ver_latest=$(echo ${info} | jq | grep "\"name" | tr '"' ' '| awk -F ' ' '{print $3}' | sort -rh | head -n 1)
    ver_8=$(echo ${info} | jq | grep "\"name" | tr '"' ' '| awk -F ' ' '{print $3}' | sort -rh | grep '^8' | head -n 1)
    ver_7=$(echo ${info} | jq | grep "\"name" | tr '"' ' '| awk -F ' ' '{print $3}' | sort -rh | grep '^7' | head -n 1)
    ver_6=$(echo ${info} | jq | grep "\"name" | tr '"' ' '| awk -F ' ' '{print $3}' | sort -rh | grep '^6' | head -n 1)
}
