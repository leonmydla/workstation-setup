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

config() {
  echo "${1}" >> $HOME/.ssh/config
}

config "RSAAuthentication no"
config "PubkeyAuthentication yes"
config "IdentityFile $HOME/.ssh/id_ed25519"

config "VisualHostKey yes"
config "CheckHostIP yes"
config "StrictHostKeyChecking yes"

config "ServerAliveInterval 300"
config "ServerAliveCountMax 1"

config "RhostsAuthentication no"
config "RhostsRSAAuthentication no"
config "HostbasedAuthentication no"

ssh-keygen -t ed25519 -a 512 -f $HOME/.ssh/id_ed25519

}
