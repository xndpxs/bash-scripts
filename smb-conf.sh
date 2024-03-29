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

# Agregar usuario a Samba
echo "Ingrese el nombre de usuario para Samba:"
read smb_user
sudo smbpasswd -a $smb_user

# Configurar un nuevo recurso compartido en Samba
echo "Ingrese el nombre del recurso compartido (share):"
read share_name
echo "Ingrese el comentario para el recurso compartido:"
read share_comment
echo "Ingrese la ruta completa del directorio a compartir:"
read share_path

# Crear la entrada en la configuración de Samba
echo "[$share_name]
   comment = $share_comment
   path = $share_path
   writable = yes
   read only = no
   valid users = $smb_user" | sudo tee -a /etc/samba/smb.conf

# Start Samba service
sudo systemctl enable smb
sudo systemctl enable nmb
sudo systemctl start smb
sudo systemctl start nmb
sudo systemctl restart smb
sudo systemctl restart nmb

echo "Configuración de Samba completada."
