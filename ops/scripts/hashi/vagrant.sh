#!/bin/sh

echo Configuring Vagrant...
# Store build time
date > /etc/vagrant_box_build_time

# Add vagrant user to passwordless sudo...
echo 'vagrant ALL=NOPASSWD:ALL' > /etc/sudoers.d/vagrant
sed -i -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

echo Install Vagrant ssh key...
mkdir -pm 700 /home/vagrant/.ssh
wget --no-check-certificate https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub -O /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys
chown -R vagrant:vagrant /home/vagrant/.ssh
