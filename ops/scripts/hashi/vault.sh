#!/bin/sh

echo Setting local variables for Vault...
REPO="hashicorp"
PROJECT="vault"
VAGRANTHOME="/home/vagrant"
BASHRCPATH="$VAGRANTHOME/.bashrc"
BIN="/usr/bin"
GOROOT="$BIN/go"
GOPATH="$VAGRANTHOME/go"
REPOPATH="$GOPATH/src/github.com/$REPO"
GODEPPATH="$GOPATH/src/github.com/tools/godep"
GOXPATH="$GOPATH/src/github.com/mitchellh/gox"
PROJECTPATH="$REPOPATH/$PROJECT"
BRANCHNAME="h-$PROJECT"
PATCH=

export GOROOT=$GOROOT
export GOPATH=$GOPATH
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

if ! [ -d "$GOROOT" ] || ! [ "$(ls -A $GOROOT)" ]; then
    sh /ops/scripts/tools/go.sh
else
    echo Skipping Go install, already installed...
fi

if ! [ -d "$GODEPPATH" ] || ! [ "$(ls -A $GODEPPATH)" ]; then
    echo Installing godep...
    go get -u github.com/tools/godep
fi

if ! [ -d "$GOXPATH" ] || ! [ "$(ls -A $GOXPATH)" ]; then
    echo Installing gox...
    go get -u github.com/mitchellh/gox
fi

if ! [ -d "$REPOPATH" ]; then
    mkdir -p $REPOPATH
fi

cd $REPOPATH

if ! [ -d "$PROJECTPATH" ] || ! [ "$(ls -A $PROJECTPATH)" ]; then
    echo Fetching $PROJECT from GitHub...
    git clone https://github.com/$REPO/$PROJECT\.git
fi

cd $PROJECTPATH

git checkout master
git pull

if [ $PATCH ]; then
    echo Applying $PROJECT patch https://github.com/$REPO/$PROJECT/pull/$PATCH
    git fetch origin pull/$PATCH/head:$BRANCHNAME
    git checkout $BRANCHNAME
    git rebase origin/master
fi

echo Building $PROJECT binaries in $PROJECTPATH/bin...
make
make dev

sudo chown -R vagrant:vagrant $GOPATH
