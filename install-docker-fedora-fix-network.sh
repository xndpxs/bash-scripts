#!/bin/bash

# Instala los plugins de DNF necesarios
sudo dnf -y install dnf-plugins-core

# Añade el repositorio oficial de Docker a tu sistema
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo

# Instala Docker y sus componentes
sudo dnf install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Inicia y habilita el servicio de Docker
sudo systemctl start docker
sudo systemctl enable docker.service

# Añade el usuario actual al grupo docker
sudo usermod -aG docker $USER
# Aplica los cambios en el grupo sin necesitar reiniciar
newgrp docker

# Crea un archivo de drop-in para añadir la regla de iptables
DOCKER_SERVICE_DROPIN_DIR="/etc/systemd/system/docker.service.d"
DOCKER_SERVICE_DROPIN="$DOCKER_SERVICE_DROPIN_DIR/override.conf"

# Creamos el directorio si no existe
sudo mkdir -p $DOCKER_SERVICE_DROPIN_DIR

# Creamos el archivo de drop-in con los cambios
echo "[Service]
ExecStartPost=/usr/sbin/iptables -I DOCKER-USER -i virbr0 -o virbr0 -j ACCEPT" | sudo tee $DOCKER_SERVICE_DROPIN

# Recargamos los archivos de unidad de systemd para aplicar los cambios
sudo systemctl daemon-reload

# Reinicia el servicio de Docker para aplicar la regla iptables
sudo systemctl restart docker.service

# Muestra un mensaje de éxito
echo "Docker y Docker Compose instalados y configurados correctamente."
