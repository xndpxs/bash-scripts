#!/bin/bash

# Actualiza los repositorios
sudo pacman -Syu

# Instala los paquetes
sudo pacman -S virt-manager qemu dnsmasq iptables-nft swtpm --noconfirm

# Agrega el usuario al grupo libvirt
sudo usermod -aG libvirt $USER

# Haz una copia de seguridad del archivo /etc/libvirt/qemu.conf
sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.bak

# Modifica el archivo /etc/libvirt/qemu.conf
sudo sed -i "/#user = \"username\"/c\user = \"$USER\"" /etc/libvirt/qemu.conf
sudo sed -i "/#group = \"username\"/c\group = \"$USER\"" /etc/libvirt/qemu.conf
