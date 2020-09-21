#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -ne 0 ]; then
  quit "./gnome.sh"
fi

sudo apt-get install \
  gnome-shell-extension-appindicator \
  gnome-shell-extension-hide-activities

sudo apt-get remove gnome-shell-extension-desktop-icons

killall -SIGQUIT gnome-shell

gnome-extensions enable ubuntu-appindicators@ubuntu.com
gnome-extensions enable Hide_Activities@shay.shayel.org

main_schema=org.gnome.settings-daemon.plugins.media-keys
main_key=custom-keybindings
sub_scheme=${main_schema}.custom-keybinding
nautilus_key=/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/nautilus_shortcut/
settings=$(gsettings get $main_schema $main_key)

if [[ $settings != *"'${nautilus_key}'"* ]]; then
  gsettings set $main_schema $main_key "${settings%]*}, '${nautilus_key}']"
fi

gsettings set ${sub_scheme}:${nautilus_key} name    'Nautilus shortcut'
gsettings set ${sub_scheme}:${nautilus_key} command 'nautilus'
gsettings set ${sub_scheme}:${nautilus_key} binding '<Super>e'

