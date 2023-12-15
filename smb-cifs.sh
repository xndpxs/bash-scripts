#!/bin/bash

# Pedir el nombre de la carpeta a crear en /mnt
read -rp "Nombre de la carpeta en /mnt: " folder_name
mnt_folder="/mnt/${folder_name}"

# Crear la carpeta en /mnt
sudo mkdir -p "$mnt_folder"

# Pedir la dirección IP del servidor de Samba
read -rp "Dirección IP del servidor de Samba: " samba_server_ip

#Pedir el nombre del share
read -rp "Nombre del share: " share_name

# Pedir las credenciales de Samba al usuario
read -rp "Samba username: " samba_user
read -rsp "Samba password: " samba_pass
echo
read -rp "Samba domain (leave empty if not needed): " samba_domain

# Crear el archivo .smbcredentials
smb_credentials_file="/home/$(whoami)/.smbcredentials"
echo "username=${samba_user}" | tee "$smb_credentials_file"
echo "password=${samba_pass}" | tee -a "$smb_credentials_file"
if [ -n "$samba_domain" ]; then
    echo "domain=${samba_domain}" | tee -a "$smb_credentials_file"
fi

# Asignar los permisos adecuados al archivo .smbcredentials
chmod 600 "$smb_credentials_file"

# Agregar la línea al archivo /etc/fstab
fstab_line="//${samba_server_ip}/${share_name} $mnt_folder cifs credentials=${smb_credentials_file},uid=$(id -u),gid=$(id -g) 0 0"
echo "$fstab_line" | sudo tee -a /etc/fstab

# Recargar el daemon de systemd para aplicar los cambios en fstab
sudo systemctl daemon-reload

# Montar el recurso compartido
sudo mount -a

echo "Configuración completada. El recurso compartido de Samba se montará automáticamente en ${mnt_folder} al iniciar el sistema."

