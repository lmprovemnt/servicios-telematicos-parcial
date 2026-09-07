#!/bin/bash

echo "=========================================="
echo " PRUEBA DE FAILOVER DNS"
echo "=========================================="

MASTER="192.168.50.2"
SLAVE="192.168.50.3"

echo
echo "[1] Comprobando DNS Master"
dig @"$MASTER" www.empresa.local A +short

echo
echo "[2] Comprobando DNS Slave"
dig @"$SLAVE" www.empresa.local A +short

echo
echo "[3] Estado de los servidores"
echo "Master: $MASTER"
echo "Slave : $SLAVE"

echo
echo "Para realizar la prueba de caída:"
echo "1. Detener dns-master:"
echo "   vagrant halt dns-master"
echo
echo "2. Consultar nuevamente el Slave:"
echo "   dig @$SLAVE www.empresa.local A +short"
echo
echo "3. El Slave debe continuar respondiendo."
echo
echo "4. Encender nuevamente el Master:"
echo "   vagrant up dns-master"

echo
echo "=========================================="
echo " FIN DE LA PRUEBA"
echo "=========================================="
