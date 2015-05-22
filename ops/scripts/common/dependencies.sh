#!/bin/sh

echo Install dependencies...
# Update the box
apt-get -y update
apt-get -y upgrade

# Install dependencies
apt-get -y install dkms
apt-get -y install nfs-common
apt-get -y install wget
apt-get -y install tar
apt-get -y install bzr
apt-get -y install git
apt-get -y install mercurial
apt-get -y install unzip
apt-get -y install build-essential
apt-get -y install curl
apt-get -y install libpcre3-dev
apt-get -y install pkg-config
apt-get -y install zip
