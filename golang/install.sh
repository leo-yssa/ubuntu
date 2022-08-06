#!/bin/bash
SCRIPT=`realpath -s $0`
SCRIPTPATH=`dirname ${SCRIPT}`
SCRIPTNAME=`basename ${SCRIPT}`

set -xe

sudo apt-get install -y curl

set +e
go version
if [ $? -ne 0 ]; then
	set -e
	GO_VER=1.16.7
	GO_URL=https://storage.googleapis.com/golang/go${GO_VER}.linux-amd64.tar.gz
	export GOROOT="/opt/go"
	export GOPATH="/opt/gopath"
	PATH=$GOROOT/bin:$GOPATH/bin:$PATH

	sudo bash -c "cat > /etc/profile.d/goroot.sh << EOF
export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=\$PATH:$GOROOT/bin:$GOPATH/bin
EOF"

	sudo mkdir -p $GOROOT
	curl -sL $GO_URL | (cd $GOROOT && sudo tar --strip-components 1 -xz)
	mkdir -p ~/gopath/src/github.com
	sudo ln -s ~/gopath /opt/gopath
fi

sudo reboot
