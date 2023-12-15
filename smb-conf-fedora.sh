#!/bin/bash

# Instalar Samba
sudo dnf install samba -y

# Habilitar y arrancar el servicio Samba
sudo systemctl enable smb --now

# Obtener zonas activas del firewall y agregar Samba a la zona de FedoraWorkstation
firewall-cmd --get-active-zones
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-service=samba
sudo firewall-cmd --reload

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

# Reiniciar el servicio Samba para aplicar los cambios
sudo systemctl restart smb

# Verificar si es necesario habilitar el servicio
if ! sudo systemctl is-enabled smb; then
    sudo systemctl enable smb
fi

echo "Configuración de Samba completada."
