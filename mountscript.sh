#!/bin/bash

# Dirección IP de tu enrutador (gateway)
GATEWAY_IP=192.168.100.1

# Esperar hasta que haya conectividad con el enrutador (gateway)
while ! ping -c 1 $GATEWAY_IP &> /dev/null; do
    sleep 1
done

# Montar los recursos compartidos utilizando 'sudo mount -a'
mount -a
