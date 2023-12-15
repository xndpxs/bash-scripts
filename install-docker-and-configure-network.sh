#!/bin/bash

# Suponiendo que tu usuario es parte del grupo sudo y que sudo está configurado
# para permitir a los miembros de tu grupo ejecutar comandos como root.

# Actualiza los paquetes y el sistema
sudo pacman -Syu --noconfirm

# Instala Docker
sudo pacman -S docker docker-compose --noconfirm

# Añade el usuario actual al grupo docker
sudo usermod -aG docker $USER

# Habilita el servicio de Docker
sudo systemctl enable docker.service

# Inicia el servicio de Docker
sudo systemctl start docker.service

# Crea un archivo de drop-in para añadir la regla de iptables
DOCKER_SERVICE_DROPIN_DIR="/etc/systemd/system/docker.service.d"
DOCKER_SERVICE_DROPIN="$DOCKER_SERVICE_DROPIN_DIR/override.conf"

# Creamos el directorio si no existe
sudo mkdir -p $DOCKER_SERVICE_DROPIN_DIR

# Creamos el archivo de drop-in con los cambios
echo "[Service]
ExecStartPost=/usr/bin/iptables -I DOCKER-USER -i virbr0 -o virbr0 -j ACCEPT" | sudo tee $DOCKER_SERVICE_DROPIN

# Recargamos los archivos de unidad de systemd para aplicar los cambios
sudo systemctl daemon-reload

# Reinicia el servicio de Docker para aplicar la regla iptables
sudo systemctl restart docker.service

# Muestra un mensaje de éxito
echo "Docker instalado y configurado correctamente."
