#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./docker.sh"
fi

sudo apt-get remove \
  docker \
  docker-engine \
  docker.io \
  containerd \
  runc

sudo apt-get install \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

key=/tmp/tmp-apt-docker.key
gpg=/etc/apt/trusted.gpg.d/docker.gpg

sudo bash -c "curl -fsSL https://download.docker.com/linux/ubuntu/gpg > $key"
sudo gpg --no-defaul-keyring --keyring $gpg --import $key
sudo rm $key

sudo echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list

sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
