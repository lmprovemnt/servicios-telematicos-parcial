# Mediciones de Compresión HTTP

## Archivo utilizado

Archivo de prueba:

`lorem.txt`

Tamaño original:

`2,097,152 bytes (2 MiB)`

El archivo fue generado con contenido altamente repetitivo para realizar las pruebas de compresión.

## Gzip / mod_deflate

| Nivel | Tamaño comprimido | Tiempo |
|---|---:|---:|
| 1 | 13,358 bytes | 0.009020 s |
| 6 | 7,239 bytes | 0.009266 s |
| 9 | 7,239 bytes | 0.015215 s |

Con nivel 9, Apache respondió:

- `Content-Encoding: gzip`
- `Content-Length: 7239`
- `Vary: Accept-Encoding`
- `Content-Type: text/plain`

## Brotli

| Nivel | Tamaño comprimido | Tiempo |
|---|---:|---:|
| 5 | 310 bytes | 0.011310 s |
| 11 | 137 bytes | 0.103892 s |

Con nivel 11, Apache respondió:

- `Content-Encoding: br`
- `Vary: Accept-Encoding`

## Comparación

Archivo original: `2,097,152 bytes`

| Algoritmo | Nivel | Tamaño | Reducción |
|---|---:|---:|---:|
| Gzip | 1 | 13,358 bytes | 99.3630% |
| Gzip | 6 | 7,239 bytes | 99.6549% |
| Gzip | 9 | 7,239 bytes | 99.6549% |
| Brotli | 5 | 310 bytes | 99.9852% |
| Brotli | 11 | 137 bytes | 99.9935% |

## Observaciones

- Gzip nivel 9 produjo el mismo tamaño que nivel 6, pero requirió más tiempo de procesamiento.
- Brotli nivel 11 obtuvo el menor tamaño comprimido, pero presentó un mayor tiempo de procesamiento.
- El archivo `lorem.txt` contiene información extremadamente repetitiva, por lo que los niveles de compresión alcanzaron reducciones excepcionalmente altas.
- Los resultados no deben interpretarse como representativos de cualquier archivo real.

## Pruebas sobre otros archivos

### index.html

- Brotli: 337 bytes
- `Content-Encoding: br`
- `Content-Type: text/html`

### estilos.css

- Brotli: 201 bytes
- `Content-Encoding: br`
- `Content-Type: text/css`

### datos.json

- Brotli: 197 bytes
- `Content-Encoding: br`
- `Content-Type: application/json`

### datos.xml

- Brotli: 235 bytes
- `Content-Encoding: br`
- `Content-Type: application/xml`

Todos presentaron:

`Vary: Accept-Encoding`

## Pruebas HTTP

Las respuestas se probaron mediante `curl` utilizando diferentes valores de:

`Accept-Encoding: gzip`

y

`Accept-Encoding: br`

También se realizó una captura con Wireshark.

En la captura se observó:

- `GET / HTTP/1.1`
- Solicitud con `Accept-Encoding: gzip, deflate, br`
- Respuesta con `Content-Encoding: gzip`

## Pruebas mediante Cloudflare Tunnel

El servidor Apache fue publicado temporalmente mediante Cloudflare Quick Tunnel.

La prueba desde un dispositivo externo confirmó que el sitio era accesible mediante Internet.

En las pruebas públicas se observaron diferencias respecto a las pruebas realizadas directamente contra Apache, por lo que los resultados del túnel no se consideran equivalentes a las mediciones locales del servidor.

## Conclusión

La configuración permitió comprobar el funcionamiento de compresión HTTP mediante Gzip y Brotli, comparar niveles de compresión y analizar el comportamiento de las respuestas HTTP mediante `curl`, herramientas de desarrollador y Wireshark.
