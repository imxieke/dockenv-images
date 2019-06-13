#!/usr/bin/env bash

docker run -d \
          -p 30022:22 \
          -p 30080:80 \
          -e RUN_MODE="remote" \
          imxieke/cmdide:homestead
