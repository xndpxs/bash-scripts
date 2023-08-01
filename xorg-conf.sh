#!/bin/bash

# Ruta del archivo de configuración de Xorg
xorg_conf="/etc/X11/xorg.conf.d/20-amdgpu.conf"

# Contenido del archivo de configuración
config_content='Section "OutputClass"
    Identifier "AMD"
    MatchDriver "amdgpu"
    Option "TearFree" "true"
    Option "AsyncFlipSecondaries" "true"
    Driver "amdgpu"
EndSection'

# Verificar si el script se está ejecutando como superusuario (root)
if [[ $EUID -ne 0 ]]; then
    echo "Este script debe ejecutarse con privilegios de superusuario (root)."
    exit 1
fi

# Crear el archivo de configuración y escribir el contenido
echo "$config_content" | sudo tee "$xorg_conf"

echo "Archivo de configuración creado en $xorg_conf."

