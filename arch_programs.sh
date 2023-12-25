#!/bin/bash

# Actualiza los repositorios y el sistema
yay -Syu

# Instala aplicaciones y utilidades
yay -S discord telegram-desktop-bin lutris gamemode protonup_qt qbittorrent samba gnome-disk-utility megasync-bin telegram steam etcher-bin variety thunderbird firefox-developer-edition paru

# Instala Wine y sus dependencias
sudo pacman -S --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

# Instala dependencias de Vulkan para Radeon
sudo pacman -S --needed lib32-mesa vulkan-radeon lib32-vulkan-radeon

