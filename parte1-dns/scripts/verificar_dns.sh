#!/bin/bash

echo "=========================================="
echo " VERIFICACION DE DNS - empresa.local"
echo "=========================================="

MASTER="192.168.50.2"
SLAVE="192.168.50.3"

echo
echo "[1] Resolucion en DNS Master"
dig @"$MASTER" empresa.local SOA +short
dig @"$MASTER" www.empresa.local A +short
dig @"$MASTER" parcial.empresa.local A +short

echo
echo "[2] Resolucion en DNS Slave"
dig @"$SLAVE" empresa.local SOA +short
dig @"$SLAVE" www.empresa.local A +short
dig @"$SLAVE" parcial.empresa.local A +short

echo
echo "[3] Resolucion inversa"
dig @"$MASTER" -x 192.168.50.2 +short
dig @"$MASTER" -x 192.168.50.3 +short
dig @"$MASTER" -x 192.168.50.10 +short
dig @"$MASTER" -x 192.168.50.20 +short

echo
echo "[4] Prueba de recursividad"
dig @"$MASTER" google.com

echo
echo "=========================================="
echo " FIN DE LAS PRUEBAS"
echo "=========================================="
