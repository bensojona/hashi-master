#!/bin/sh

echo Setting local variables for environment...
VAGRANTHOME="/home/vagrant"
BASHPROFILEPATH="$VAGRANTHOME/.bash_profile"
BASHRCPATH="$VAGRANTHOME/.bashrc"
TMP="/tmp"

echo Setting environment variables...
BASHPROFILE="[[ -r $BASHRCPATH ]] && . $BASHRCPATH"

if [ -s "BASHPROFILEPATH" ] && grep -Fxq "$BASHPROFILE" $BASHPROFILEPATH; then
    echo $VAGRANTHOME/.bash_profile already updated
else
    echo "$BASHPROFILE" | tee -a $BASHPROFILEPATH
fi

sh -c echo -e "\n" >> $BASHRCPATH
echo "alias p='packer'" | tee -a $BASHRCPATH
echo "alias t='terraform'" | tee -a $BASHRCPATH
echo "alias c='consul'" | tee -a $BASHRCPATH
echo "alias v='vault'" | tee -a $BASHRCPATH
echo "alias d='docker'" | tee -a $BASHRCPATH
echo "alias g='git'" | tee -a $BASHRCPATH

echo Configuring git...
git config --global user.email "bensojon@gmail.com"
git config --global user.name "Jon Benson"

cd $TMP

echo Setting login directory...
echo "cd $VAGRANTHOME/ops" | tee -a $BASHRCPATH
