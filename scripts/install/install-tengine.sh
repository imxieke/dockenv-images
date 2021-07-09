#!/usr/bin/env bash
LATEST_VERSION=$(curl -s https://api.github.com/repos/alibaba/tengine/releases/latest | grep 'tag_name' | awk -F '"' '{print $4}')
# wget https://github.com/alibaba/tengine/archive/2.3.2.zip
wget https://github.com/alibaba/tengine/archive/${LATEST_VERSION}.zip