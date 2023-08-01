#!/bin/bash

# Comando para obtener información de los monitores
monitor_info=$(xrandr --query | grep ' connected')

# Ruta del archivo de configuración Xsetup
xsetup_file="/usr/share/sddm/scripts/Xsetup"

# Borra el archivo de configuración Xsetup si ya existe
if [ -f "$xsetup_file" ]; then
  sudo rm "$xsetup_file"
fi

# Crea el archivo de configuración Xsetup
sudo touch "$xsetup_file"
sudo chmod +x "$xsetup_file"

# Recorre las líneas de salida para obtener los nombres y configuraciones de los monitores
while IFS= read -r line; do
  monitor_name=$(echo "$line" | awk '{print $1}') # Extrae el nombre del monitor

  mode=$(xrandr --query | grep -w "$monitor_name" | grep -oP '\d+x\d+' | head -n1) # Extrae el modo (resolución)
  pos=$(xrandr --query | grep -w "$monitor_name" | grep -oP '\d+x\d+\+\d+\+\d+' | awk -F'+' '{print $2"x"$3}') # Extrae la posición

  # Puedes modificar esta parte según tus preferencias de configuración
  xrandr_command="xrandr --output $monitor_name --mode $mode --pos $pos --rotate normal"

  # Añadir el comando al archivo de configuración Xsetup si no existe previamente
  if ! grep -q "$xrandr_command" "$xsetup_file"; then
    echo "$xrandr_command" | sudo tee -a "$xsetup_file"
  fi
done <<< "$monitor_info"

# Agrega las líneas necesarias al final de /etc/sddm.conf si no existen previamente
if ! grep -q "DisplayCommand=/usr/share/sddm/scripts/Xsetup" "/etc/sddm.conf"; then
  echo -e "\n[XDisplay]" | sudo tee -a /etc/sddm.conf
  echo "# Xsetup script path" | sudo tee -a /etc/sddm.conf
  echo "# A script to execute when starting the display server" | sudo tee -a /etc/sddm.conf
  echo "DisplayCommand=/usr/share/sddm/scripts/Xsetup" | sudo tee -a /etc/sddm.conf
fi

echo "Archivo de configuración Xsetup creado y configurado con éxito. Configuración agregada a /etc/sddm.conf."
