#!/bin/sh

echo Setting local variables for Go...
VAGRANTHOME="/home/vagrant"
BASHRCPATH="$VAGRANTHOME/.bashrc"
TMP="/tmp"
BIN="/usr/bin"
GOROOT="$BIN/go"
GOPATH="$VAGRANTHOME/go"

cd $TMP

echo Fetching go...
wget --quiet --no-check-certificate https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz -q -O go.tar.gz

echo Installing Go...
tar -xzf go.tar.gz
sudo mv go $BIN
sudo chmod 775 $GOROOT
sudo chown -R vagrant:vagrant $GOROOT
sudo mkdir -p $GOPATH
sudo chown -R vagrant:vagrant $GOPATH

echo "export GOROOT=$GOROOT" | tee -a $BASHRCPATH
export GOROOT=$GOROOT
echo "export GOPATH=$GOPATH" | tee -a $BASHRCPATH
export GOPATH=$GOPATH
echo "export PATH=$PATH:$GOROOT/bin:$GOPATH/bin" | tee -a $BASHRCPATH
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
