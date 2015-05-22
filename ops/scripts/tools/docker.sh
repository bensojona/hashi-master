#!/bin/sh

echo Installing Docker...
wget -qO- https://get.docker.io/ | sh

echo Configuring Docker...
sed -i -- 's/#DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"/DOCKER_OPTS="--dns 8.8.8.8 --dns 8.8.4.4"/g' /etc/default/docker
echo "DOCKER_OPTS=\"-r=true \${DOCKER_OPTS}\"" | tee -a /etc/default/docker
sudo usermod -a -G docker vagrant
service docker restart
