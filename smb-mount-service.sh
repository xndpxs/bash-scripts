#!/bin/bash

# Preguntar por el nombre del servicio
read -p "Ingrese el nombre del servicio (sin espacios): " service_name

# Preguntar por la descripción del servicio
read -p "Ingrese la descripción del servicio: " service_description

# Preguntar por la ubicación del script ExecStart
read -p "Ingrese la ubicación completa del script ExecStart (incluyendo el nombre del script): " execstart_path

# Crear el archivo de servicio de systemd
service_file="/etc/systemd/system/${service_name}.service"

echo "[Unit]" > $service_file
echo "Description=$service_description" >> $service_file
echo "Wants=network-online.target" >> $service_file
echo "After=network-online.target" >> $service_file
echo "" >> $service_file
echo "[Service]" >> $service_file
echo "ExecStart=$execstart_path" >> $service_file
echo "" >> $service_file
echo "[Install]" >> $service_file
echo "WantedBy=multi-user.target" >> $service_file

# Habilitar y arrancar el servicio
systemctl enable $service_name
systemctl start $service_name

# Mostrar el estado del servicio
systemctl status $service_name

