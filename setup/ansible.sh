#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./ansible.sh"
fi

sudo apt-get install ansible

echo "stdout_callback = yaml" >> /etc/ansible/ansible.cfg
