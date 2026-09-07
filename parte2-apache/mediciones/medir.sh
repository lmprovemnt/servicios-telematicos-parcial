#!/bin/bash

echo "=========================================="
echo " MEDICIONES DE COMPRESION HTTP"
echo "=========================================="

URL="http://192.168.50.10/lorem.txt"

echo
echo "[1] Sin compresion"
curl -s -o /dev/null \
    -w "HTTP=%{http_code} SIZE=%{size_download} TIME=%{time_total}\n" \
    "$URL"

echo
echo "[2] Gzip"
curl -s -H "Accept-Encoding: gzip" -o /dev/null \
    -w "HTTP=%{http_code} SIZE=%{size_download} TIME=%{time_total}\n" \
    "$URL"

echo
echo "[3] Brotli"
curl -s -H "Accept-Encoding: br" -o /dev/null \
    -w "HTTP=%{http_code} SIZE=%{size_download} TIME=%{time_total}\n" \
    "$URL"

echo
echo "[4] Encabezados Gzip"
curl -I -H "Accept-Encoding: gzip" "$URL"

echo
echo "[5] Encabezados Brotli"
curl -I -H "Accept-Encoding: br" "$URL"

echo
echo "=========================================="
echo " FIN DE LAS MEDICIONES"
echo "=========================================="
