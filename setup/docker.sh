#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./docker.sh"
fi

sudo apt-get install -y \
  apt-transport-https \
  ca-certificates \
  curl \
  gnupg-agent \
  software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo bash -c "echo \"deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" > /etc/apt/sources.list.d/docker.list"

sudo apt-get update
sudo apt-get install -y \
  docker-ce \
  docker-ce-cli \
  containerd.io

docker_group=docker
docker_old_gid=$(getent group $docker_group | cut --delimiter=: --fields=3)
docker_new_gid=999
old_gid_999=$(getent group $docker_new_gid | cut --delimiter=: --fields=1)

if [[ $docker_old_gid -eq $docker_new_gid ]]; then
  quit "Docker already has the correct gid"
fi

temp_gid=60000

for i in $(seq 60000 60100); do
  if [[ $(getent group $i | wc --chars) -le 0 ]]; then
    temp_gid=$i
    break
  fi
done

sudo groupmod --gid $temp_gid $old_gid_999
sudo groupmod --gid $docker_new_gid $docker_group
sudo groupmod --gid $docker_old_gid $old_gid_999
