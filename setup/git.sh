#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./git.sh"
fi

gpg_key_conf=/tmp/gpg_key_conf

sudo apt-get install -y \
  git \
  openssh-client

echo "Enter the name to use for git:"
read git_name
echo "Enter the mail to use for git:"
read git_mail

git config --global user.name "${git_name}"
git config --global user.email "${git_mail}"

printf "Host github.com\n  User git\n" >> $HOME/.ssh/config
