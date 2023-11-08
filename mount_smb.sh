#!/bin/bash

# Esperar a que haya conexión a internet
while ! ping -c1 google.com &>/dev/null; do sleep 1; done

# Intenta montar el recurso compartido SMB
mount -a
