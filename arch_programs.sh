#!/bin/bash

# Function to install a package from the AUR
install_from_aur() {
    package_name="$1"
    git clone "https://aur.archlinux.org/$package_name.git" /tmp/"$package_name"
    cd /tmp/"$package_name" && makepkg -si
    cd - && rm -rf /tmp/"$package_name"
}

# Update repositories
sudo pacman -Syu

# Install programs from official repositories
sudo pacman -S --needed base-devel git discord telegram-desktop lutris wine gamemode protonup_qt qbittorrent samba gnome-disk-utility virt-manager qemu dnsmasq iptables-nft

# Install programs from the AUR
install_from_aur "yay"  # AUR helper (you can replace it with your favorite AUR helper)

echo "Installation completed."

