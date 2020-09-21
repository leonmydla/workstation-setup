#!/usr/bin/env bash

set -eu

if [ $# -ne 0 ]; then
  quit "./apt.sh"
fi

>                                                                                                                               /etc/apt/sources.list
echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ "$(lsb_release -sc)" main restricted universe multiverse"           >> /etc/apt/sources.list
echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ "$(lsb_release -sc)"-updates main restricted universe multiverse"   >> /etc/apt/sources.list
echo "deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ "$(lsb_release -sc)"-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb [arch=amd64] http://security.ubuntu.com/ubuntu/ "$(lsb_release -sc)"-security main restricted universe multiverse" >> /etc/apt/sources.list
echo ""                                                                                                                      >> /etc/apt/sources.list
echo "# deb-src http://archive.ubuntu.com/ubuntu/ "$(lsb_release -sc)" main restricted universe multiverse"                  >> /etc/apt/sources.list
echo "# deb-src http://archive.ubuntu.com/ubuntu/ "$(lsb_release -sc)"-updates main restricted universe multiverse"          >> /etc/apt/sources.list
echo "# deb-src http://archive.ubuntu.com/ubuntu/ "$(lsb_release -sc)"-backports main restricted universe multiverse"        >> /etc/apt/sources.list
echo "# deb-src http://security.ubuntu.com/ubuntu/ "$(lsb_release -sc)"-security main restricted universe multiverse"        >> /etc/apt/sources.list
echo ""                                                                                                                      >> /etc/apt/sources.list
echo "deb [arch=amd64] http://archive.canonical.com/ubuntu "$(lsb_release -sc)" partner"                                     >> /etc/apt/sources.list
echo ""                                                                                                                      >> /etc/apt/sources.list
echo "# deb-src http://archive.canonical.com/ubuntu "$(lsb_release -sc)" partner"                                            >> /etc/apt/sources.list

sudo apt-get update
sudo apt-get upgrade
