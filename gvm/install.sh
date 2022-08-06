#!/bin/bash

sudo apt-get install -y make bison

bash < <(curl -s -S -L https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
source /home/yssa/.gvm/scripts/gvm

gvm listall # 설치 가능한 golang 버전 조회

GO_VERSION=go1.14.15
gvm install $GO_VERSION -B
gvm use $GO_VERSION --default