#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./ssh.sh"
fi

sudo apt-get install openssh-client

config=$HOME/.ssh/config

echo "RSAAuthentication no"           >> $config
echo "PubkeyAuthentication yes"       >> $config
echo "IdentityFile $HOME/.ssh/id_ed25519" >> $config

echo "VisualHostKey yes"              >> $config
echo "CheckHostIP yes"                >> $config
echo "StrictHostKeyChecking yes"      >> $config

echo "ServerAliveInterval 300"        >> $config
echo "ServerAliveCountMax 1"          >> $config

echo "RhostsAuthentication no"        >> $config
echo "RhostsRSAAuthentication no"     >> $config
echo "HostbasedAuthentication no"     >> $config

ssh-keygen -t ed25519 -a 512 -f $HOME/.ssh/id_ed25519
