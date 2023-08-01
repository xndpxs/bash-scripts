#!/bin/bash

# Función para agregar una línea al final del archivo /etc/fstab
add_to_fstab() {
    echo "$1" | sudo tee -a /etc/fstab
}

# Verificar si el script se está ejecutando como superusuario (root)
if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse con privilegios de superusuario (root)."
    exit 1
fi

# Agregar las líneas al archivo /etc/fstab
add_to_fstab "LABEL=libreria /mnt/libreria auto nosuid,nodev,nofail,x-gvfs-show,x-gvfs-name=libreria 0 0"
add_to_fstab "LABEL=vms /mnt/vms auto nosuid,nodev,nofail,x-gvfs-show,x-gvfs-name=vms 0 0"
add_to_fstab "LABEL=descargas /mnt/descargas auto nosuid,nodev,nofail,x-gvfs-show,x-gvfs-name=descargas 0 0"

echo "Líneas agregadas al archivo /etc/fstab correctamente."

