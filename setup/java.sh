#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./java.sh"
fi

sudo apt-get install -y \
  openjdk-11-dbg \
  openjdk-11-doc \
  openjdk-11-jdk \
  openjdk-11-source
