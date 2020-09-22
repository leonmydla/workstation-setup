#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./applications.sh"
fi

run_install() {
  echo "Installing $1 ..."
  $2
  echo "Done: $1 !"
  echo ""
}

chrome_install() {
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
  sudo apt-get update
  sudo apt-get install google-chrome-stable
}

jetbrains_install() {
  toolbox_folder=$HOME/Downloads/jetbrains-toolbox
  toolbox_file=$toolbox_folder/toolbox.tar.gz

  echo "Enter the url for the toolbox .tar.gz download:"
  read toolbox_url

  mkdir -p $toolbox_folder
  wget $toolbox_url -O $toolbox_file

  cd $toolbox_folder
  tar -zxvf $toolbox_file
  ./jetbrains-toolsbox-*/jetbrains-toolbox &

  sleep 30

  set +e
  killall -SIGKILL jetbrains-toolbox
  set -e
}

dropbox_install() {
  cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
}

discord_install() {
  discord_file=$HOME/Downloads/discord.deb

  wget "https://discord.com/api/download?platform=linux&format=deb" -O $discord_file
  sudo dpkg --install $discord_file
}

teams_install() {
  teams_file=$HOME/Downloads/teams.deb

  wget "https://go.microsoft.com/fwlink/p/?LinkID=2112886&clcid=0x409&culture=en-us&country=US" -O $teams_file
  sudo dpkg --install $teams_file
}

snap_install() {
  run_install "$1 (snap)" "snap install $1"
}

snap_install_classic() {
  run_install "$1 (snap)" "snap install --classic $1"
}

run_install Chrome chrome_install
run_install "Jetbrains Toolbox" jetbrains_install
run_install Dropbox dropbox_install
run_install Discord discord_install
run_install Gimp "sudo apt-get install gimp"
run_install Inkscape "sudo apt-get install inkscape"
run_install "Pulse Audio Volume Control" "sudo apt-get install pavucontrol"

snap_install spotify
snap_install chromium
snap_install_classic skype
