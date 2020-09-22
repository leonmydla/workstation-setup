#!/usr/bin/env bash

set -eux

quit() {
  echo "$@"
  exit 1
}

dir=$(dirname $(realpath $0))

if [ $# -ne 0 ]; then
  quit "./setup.sh"
fi

setup() {
  echo "Setting up $1 ..."
  ${dir}/setup/${1}.sh
  echo "Done: $1 !"
  echo ""
}

setup apt
setup docker
setup java
setup node
setup ansible

setup shell
setup ssh
setup git

setup gnome

setup applications
