#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./apt.sh"
fi

sources_list() {
  sudo bash -c 'echo "${1}" >> /etc/apt/sources.list'
}

sudo bash -c "> /etc/apt/sources.list"
sources_list "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse"
sources_list "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse"
sources_list "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-backports main restricted universe multiverse"
sources_list "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ $(lsb_release -sc)-security main restricted universe multiverse"
sources_list ""
sources_list "# deb-src http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc) main restricted universe multiverse"
sources_list "# deb-src http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-updates main restricted universe multiverse"
sources_list "# deb-src http://archive.ubuntu.com/ubuntu/ $(lsb_release -sc)-backports main restricted universe multiverse"
sources_list "# deb-src http://security.ubuntu.com/ubuntu/ $(lsb_release -sc)-security main restricted universe multiverse"
sources_list ""
sources_list "deb [arch=amd64] http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"
sources_list ""
sources_list "# deb-src http://archive.canonical.com/ubuntu $(lsb_release -sc) partner"

sudo apt-get update
sudo apt-get upgrade
