#!/usr/bin/env bash

# Description: Script to install and configure Samba in Arch Linux.
# Author: Winkey Wong.
# Date: 2018-04-11

#
# How to use:
#   chmod +x samba.sh
#   ./samba.sh PATH_TO_SHARED_DIRECTORY  PERMISSIONS
#
#
# $1 = path , e.g. /home/myuser/publicdir
# $2 = permissions  ,  e.g  755
#

if [ -z "$1" ];then
    echo "How to use this script?"
    echo "./samba.sh  PATH_TO_SHARED_DIRECTORY  PERMISSIONS"
    exit 0
fi

if [ -z "$2" ];then
    echo "Pass the persmissions of the directory you want to share as the second parameter."
    exit 0
fi

# Install Samba

samba_not_installed=$(pacman -Qqe | grep "samba")
if [ -n "$samba_not_installed" ]; then
    echo "Installing samba"
    sudo pacman --noconfirm -S samba
fi

# Get Samba configuration file

sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf

# Configure directory that will be accessed with Samba

echo "
[descargas]
comment = Compartida de descargas
path = /mnt/descargas
writable = yes
read only = no

" | sudo tee -a /etc/samba/smb.conf

# Give permissions to shared directory

sudo chmod $2 $1

# Start Samba service

systemctl enable smbd.service
systemctl enable nmbd.service
systemctl start smbd.service
systemctl start nmbd.service

# Add Samba user and setup password

printf "Samba user: "
read -r
user="$REPLY"
sudo smbpasswd -a "$user"
