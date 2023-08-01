#!/bin/bash

# Preguntar por el nombre del puente de red
read -rp "Nombre del puente de red: " bridge_name

# Preguntar por el interfaz físico que será parte del puente
read -rp "Nombre del interfaz físico que será parte del puente: " physical_interface

# Preguntar por la dirección IP y la máscara de red para el host
read -rp "Dirección IP y máscara de red para el host (ejemplo: 192.168.100.2/24): " host_ip

# Preguntar por la dirección IP del gateway para el host
read -rp "Dirección IP del gateway para el host (ejemplo: 192.168.100.1): " gateway_ip

# Preguntar por la dirección IP de los servidores DNS para el host
read -rp "Direcciones IP de los servidores DNS para el host (separadas por espacios, ejemplo: 192.168.100.1 8.8.8.8): " dns_servers

# Verificar que el paquete bridge-utils está instalado
if ! command -v brctl &>/dev/null; then
    echo "El paquete bridge-utils no está instalado. Instálalo primero para configurar el puente de red."
    exit 1
fi

# Crear el archivo de configuración para el puente
bridge_config="/etc/netctl/$bridge_name"
echo "Description=\"Bridge interface\"" > "$bridge_config"
echo "Interface=$bridge_name" >> "$bridge_config"
echo "Connection=bridge" >> "$bridge_config"
echo "BindsToInterfaces=($physical_interface)" >> "$bridge_config"
echo "IP=static" >> "$bridge_config"
echo "Address=('$host_ip')" >> "$bridge_config"
echo "Gateway='$gateway_ip'" >> "$bridge_config"
echo "DNS=($dns_servers)" >> "$bridge_config"

# Habilitar el servicio de red para el puente de red
sudo systemctl enable "netctl-auto@$bridge_name.service"

echo "El puente de red $bridge_name se ha creado y configurado correctamente con la dirección IP $host_ip y la configuración persistente."

