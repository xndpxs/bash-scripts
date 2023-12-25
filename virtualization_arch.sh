#!/bin/bash

# Actualiza los repositorios
sudo pacman -Syu

# Instala los paquetes
sudo pacman -S virt-manager qemu-full dnsmasq iptables-nft swtpm edk2-ovmf vde2 bridge-utils virt-viewer --noconfirm

# Agrega el usuario al grupo libvirt
sudo usermod -aG libvirt $USER

# Haz una copia de seguridad del archivo /etc/libvirt/qemu.conf
sudo cp /etc/libvirt/qemu.conf /etc/libvirt/qemu.conf.bak

# Modifica el archivo /etc/libvirt/qemu.conf
sudo sed -i "/#user = \"username\"/c\user = \"$USER\"" /etc/libvirt/qemu.conf
sudo sed -i "/#group = \"username\"/c\group = \"$USER\"" /etc/libvirt/qemu.conf

# Habilita e inicia el servicio libvirtd
sudo systemctl enable libvirtd.service
sudo systemctl start libvirtd.service
sudo systemctl restart libvirtd.service

# Verifica si el archivo libvirtd.conf necesita ser editado
if ! grep -q "^unix_sock_group = \"libvirt\"" /etc/libvirt/libvirtd.conf; then
    sudo sed -i "/#unix_sock_group =/c\unix_sock_group = \"libvirt\"" /etc/libvirt/libvirtd.conf
fi

if ! grep -q "^unix_sock_rw_perms = \"0770\"" /etc/libvirt/libvirtd.conf; then
    sudo sed -i "/#unix_sock_rw_perms =/c\unix_sock_rw_perms = \"0770\"" /etc/libvirt/libvirtd.conf
fi

# Reinicia el servicio libvirtd después de realizar los cambios
sudo systemctl restart libvirtd.service

# Verifica el estado del servicio
systemctl status libvirtd.service
