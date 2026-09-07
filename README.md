# Servicios Telemáticos — Parcial

Infraestructura virtualizada para el laboratorio de Servicios Telemáticos, implementada con Vagrant, VirtualBox, Ubuntu 24.04, BIND9, Apache HTTP Server, Gzip, Brotli y Cloudflare Tunnel.

## 1. Descripción

El proyecto implementa una infraestructura de red virtualizada compuesta por cuatro máquinas:

| Máquina    | Hostname              | IP            | Función                 |
| ---------- | --------------------- | ------------- | ----------------------- |
| DNS Master | maestro.empresa.local | 192.168.50.2  | Servidor DNS principal  |
| DNS Slave  | esclavo.empresa.local | 192.168.50.3  | Servidor DNS secundario |
| Web        | web.empresa.local     | 192.168.50.10 | Servidor Apache         |
| Client     | cliente.empresa.local | 192.168.50.20 | Cliente de pruebas      |

Dominio principal:

`empresa.local`

Red privada:

`192.168.50.0/24`

## 2. Tecnologías utilizadas

* Vagrant
* VirtualBox
* Ubuntu 24.04 ARM64
* BIND9
* DNS
* TSIG
* AXFR
* IXFR
* NOTIFY
* Apache HTTP Server
* HTTP/1.1
* Gzip
* Brotli
* curl
* Wireshark
* Chrome/Opera DevTools
* Cloudflare Tunnel

## 3. Infraestructura

La infraestructura se reproduce mediante el archivo:

`Vagrantfile`

El archivo define las cuatro máquinas virtuales, sus nombres, direcciones IP, recursos y red privada.

## 4. DNS

Se implementó una arquitectura DNS Master/Slave para `empresa.local`.

### DNS Master

IP:

`192.168.50.2`

Responsabilidades:

* Resolver registros DNS.
* Servir la zona `empresa.local`.
* Servir la zona inversa `50.168.192.in-addr.arpa`.
* Permitir transferencias autenticadas mediante TSIG.
* Notificar cambios al servidor secundario.
* Mantener deshabilitada la recursión.

### DNS Slave

IP:

`192.168.50.3`

Responsabilidades:

* Mantener una copia secundaria de las zonas.
* Recibir transferencias desde el Master.
* Actualizarse mediante NOTIFY.
* Continuar resolviendo las zonas cuando el Master está temporalmente fuera de servicio.

### Seguridad DNS

Las transferencias de zona se protegieron mediante una clave TSIG utilizando:

* Nombre: `esclavo-transfer`
* Algoritmo: `hmac-sha256`

La clave real no se almacena en el repositorio.

Se incluye únicamente un archivo de ejemplo:

`parte1-dns/maestro/esclavo.key.example`

## 5. Pruebas DNS realizadas

Durante el laboratorio se verificaron:

* Validación de configuración de BIND.
* Resolución de registros.
* Transferencia AXFR autenticada mediante TSIG.
* Bloqueo de AXFR sin la clave.
* NOTIFY entre Master y Slave.
* Actualización de registros mediante cambio de serial.
* Diferencias entre AXFR e IXFR.
* Recursión DNS deshabilitada.
* Registro de consultas y transferencias.
* Funcionamiento del DNS Slave durante una caída del Master.

## 6. Servidor Web

El servidor Web utiliza Apache HTTP Server.

IP:

`192.168.50.10`

VirtualHost:

`parcial.empresa.local`

Contenido publicado:

* `index.html`
* `estilos.css`
* `app.js`
* `datos.json`
* `datos.xml`
* `imagen.svg`
* `lorem.txt`

## 7. Compresión HTTP

Se configuró compresión mediante:

### Gzip

Se utilizó `mod_deflate` con niveles de compresión:

* Nivel 1
* Nivel 6
* Nivel 9

### Brotli

Se configuró `mod_brotli` con niveles:

* Nivel 5
* Nivel 11

Se realizaron mediciones de:

* Tamaño original.
* Tamaño comprimido.
* Tiempo de procesamiento.
* Ratio de compresión.
* Porcentaje de reducción.
* Encabezado `Content-Encoding`.

## 8. Resultados principales de compresión

Archivo utilizado para la comparación:

`lorem.txt`

Tamaño original:

`2,097,152 bytes`

Resultados obtenidos:

| Algoritmo | Nivel | Tamaño comprimido |
| --------- | ----: | ----------------: |
| Gzip      |     1 |      13,358 bytes |
| Gzip      |     6 |       7,239 bytes |
| Gzip      |     9 |       7,239 bytes |
| Brotli    |     5 |         310 bytes |
| Brotli    |    11 |         137 bytes |

Los resultados muestran que aumentar el nivel de compresión no siempre proporciona una mejora proporcional al tiempo de procesamiento.

## 9. Pruebas HTTP

Se verificó la negociación de compresión utilizando `curl` con:

`Accept-Encoding: gzip`

y

`Accept-Encoding: br`

También se realizaron capturas mediante Wireshark para comprobar el tráfico HTTP y los encabezados de compresión.

## 10. Acceso externo

Se utilizó Cloudflare Quick Tunnel para publicar temporalmente el servidor Web hacia Internet.

La prueba permitió:

* Acceder al sitio desde un dispositivo externo.
* Verificar que Apache respondiera a través del túnel.
* Comparar el comportamiento de la compresión local y a través del túnel.

El túnel utilizado durante las pruebas fue temporal y no representa una configuración de producción.

## 11. Seguridad

Se analizaron los riesgos asociados con la exposición del servidor:

* Apache escuchando en el puerto 80.
* SSH escuchando en el puerto 22.
* Firewall UFW deshabilitado en el entorno de laboratorio.
* Exposición temporal del servidor mediante Cloudflare Tunnel.
* Riesgo de publicar accidentalmente archivos sensibles.
* Necesidad de autenticación y control de acceso en ambientes reales.

## 12. Reproducción

Para crear la infraestructura:

```bash
vagrant up
```

Para consultar las máquinas:

```bash
vagrant status
```

Para acceder a una máquina:

```bash
vagrant ssh dns-master
vagrant ssh dns-slave
vagrant ssh web
vagrant ssh client
```

Para detener la infraestructura:

```bash
vagrant halt
```

Para destruir las máquinas:

```bash
vagrant destroy
```

## 13. Evidencias

La carpeta del proyecto contiene configuraciones, scripts, páginas web y mediciones utilizadas durante el laboratorio.

Las pruebas y resultados se documentan dentro de:

* `parte1-dns/scripts/`
* `parte2-apache/mediciones/`
* `parte3-tunel/`

El objetivo es que el repositorio permita revisar tanto la configuración como las pruebas realizadas y reproducir la infraestructura.

## 14. Seguridad del repositorio

No se debe almacenar información sensible.

La clave TSIG real está excluida mediante `.gitignore`.

Se utiliza un archivo de ejemplo para mostrar la estructura esperada:

`esclavo.key.example`

