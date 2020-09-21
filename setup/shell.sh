#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./shell.sh"
fi

lib=$HOME/lib
zshrc=$HOME/.zshrc
zshrc_old=${zshrc}.old

sudo apt-get install curl git

curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash -

mkdir -p $lib

git clone https://github.com/leonmydla/shell-commons $lib/shell-commons

if [[ -f $zshrc ]]; then
  mv $zshrc $zshrc_old
fi

cp $lib/shell-commons/zshrc.zsh-template $zshrc
