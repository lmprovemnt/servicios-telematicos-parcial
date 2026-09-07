# Parte 3 — Cloudflare Tunnel

## Objetivo

Publicar temporalmente el servidor web Apache de la infraestructura
virtualizada para comprobar el acceso desde un dispositivo externo.

## Servidor publicado

- IP: `192.168.50.10`
- Servicio: Apache HTTP Server
- Puerto: `80`

## Herramienta utilizada

Se utilizó Cloudflare Tunnel mediante `cloudflared`.

Versión utilizada durante la práctica:

`2026.8.3`

## Instalación

En macOS se instaló `cloudflared` mediante Homebrew:

```bash
brew install cloudflared
