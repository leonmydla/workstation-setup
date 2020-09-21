#!/usr/bin/env bash

set -eu

quit() {
  echo "$@"
  exit 1
}

if [ $# -lt 2 ]; then
  quit "./lvm-on-luks.sh <disk> <swap size> | eg.: ./lvm-on-luks.sh /dev/sda3 16G"
fi

device_disk=$1
swap_size=$2

validate_yes() {
  echo $1
  printf "[y/n]: "
  read yes_no_input
  printf "\n"

  if [[ $yes_no_input != "y" ]]; then
    quit $2
  fi
}


if ! [[ $device_disk =~ ^/dev/.+ ]]; then
  quit "You did not enter a valid partition block device!"
fi

validate_yes \
  "Please validate that you entered the correct partitions block device '$device_disk' [ATTENTION, YOUR INPUT WILL NOT BE VALIDATED]" \
  "You seem to be uncertain that the device you entered is the device you want to setup for encryption!"

if ! [[ $swap_size =~ ^[0-9]+[MGT]$ ]]; then
  quit "You did not enter a valid swap size!"
fi


encryption_name=cryptlvm
virtual_decrypted_disk=/dev/mapper/$encryption_name
lvm_group=CryptLvmGroup
swap_name=swap
root_name=root

exit 1
cryptsetup luksFormat $device_disk
cryptsetup open $device_disk $encryption_name

pvcreate $virtual_decrypted_disk
vgcreate $lvm_group $virtual_decrypted_disk
lvcreate -L $swap_size $lvm_group -n $swap_name
lvcreate -l 100%FREE $lvm_group -n $root_name

mkfs.ext4 /dev/$lvm_group/$root_name
mkswap /dev/$lvm_group/$swap_name

encrypted_disk_uuid=`blkid $virtual_decrypted_disk | sed -n 's/.*UUID=\"\([^\"]*\)\".*/\1/p'`

echo "cryptdevice=UUID="
