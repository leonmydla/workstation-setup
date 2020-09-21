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
  echo "Setting up ${0} ..."
  ${dir}/setup/${0}.sh
  echo "Done: ${0} !"
  echo ""
}

setup apt
setup docker
setup java
setup node

setup shell
setup ssh
setup git

setup gnome

# applications
#spotify
#jetbrains
#chrome
#chromium
#discord
#dropbox
#gimp
#inkscape
#skype #snap
#teams
