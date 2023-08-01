#!/usr/bin/env bash

# Description: Script to install and configure Samba in Arch Linux.
# Author: Winkey Wong.
# Date: 2018-04-11

# Install Samba if not already installed
if ! pacman -Qq samba &>/dev/null; then
    echo "Installing samba"
    sudo pacman --noconfirm -S samba
fi

# Get Samba configuration file if it doesn't exist
if [ ! -f /etc/samba/smb.conf ]; then
    sudo wget "https://git.samba.org/samba.git/?p=samba.git;a=blob_plain;f=examples/smb.conf.default;hb=HEAD" -O /etc/samba/smb.conf
fi

# Configure directory that will be accessed with Samba
share_config='[descargas]
comment = Compartida de descargas
path = /mnt/descargas
writable = yes
read only = no'

echo "$share_config" | sudo tee -a /etc/samba/smb.conf

# Start Samba service
sudo systemctl enable smbd.service
sudo systemctl enable nmbd.service
sudo systemctl start smbd.service
sudo systemctl start nmbd.service

# Add Samba user and setup password
read -rp "Samba user: " user
sudo smbpasswd -a "$user"
