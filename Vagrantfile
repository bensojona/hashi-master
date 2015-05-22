# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
Vagrant.require_version ">= 1.6.0"
VAGRANTFILE_API_VERSION = "2"

$script = <<SCRIPT
echo Setting environment variables...
BASHRCPATH="/home/vagrant/.bashrc"
sudo sh -c echo -e "\n" >> $BASHRCPATH
echo "export ATLAS_USERNAME='$1'" | sudo tee -a $BASHRCPATH
echo "export ATLAS_TOKEN='$2'" | sudo tee -a $BASHRCPATH
echo "export AWS_ACCESS_KEY='$3'" | sudo tee -a $BASHRCPATH
echo "export AWS_SECRET_KEY='$4'" | sudo tee -a $BASHRCPATH
echo "export DOCKER_LOGIN_EMAIL='$5'" | sudo tee -a $BASHRCPATH
echo "export DOCKER_USER_NAME='$6'" | sudo tee -a $BASHRCPATH
echo "export DOCKER_PASSWORD='$7'" | sudo tee -a $BASHRCPATH
echo "export DOCKER_LOGIN_SERVER='$8'" | sudo tee -a $BASHRCPATH
sudo chown -R vagrant:vagrant /home/vagrant/go

echo Configuring Docker...

if grep -Fxq "nameserver 8.8.8.8" /etc/resolv.conf; then
    echo nameserver 8.8.8.8 already exists...
else
    echo "nameserver 8.8.8.8" | sudo tee -a /etc/resolv.conf
fi

sudo service docker restart
SCRIPT

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

  config.vm.define "hashi-master" do |v|
    v.vm.hostname = "hashi-master"
    v.vm.box = "jb_hashicorp/hashi-master"
    v.vm.synced_folder ".", "/home/vagrant"

    v.vm.provision "shell" do |s|
      s.inline = $script
      s.args = [
        ENV['ATLAS_USERNAME'],
        ENV['ATLAS_TOKEN'],
        ENV['AWS_ACCESS_KEY'],
        ENV['AWS_SECRET_KEY'],
        ENV['DOCKER_LOGIN_EMAIL'],
        ENV['DOCKER_USER_NAME'],
        ENV['DOCKER_PASSWORD'],
        ENV['DOCKER_LOGIN_SERVER']
      ]
    end
  end
end
