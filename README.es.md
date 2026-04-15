*Este proyecto forma parte del cursus de 42 y ha sido realizado por jpuerto-.*

# Inception

## Descripción

Inception es un proyecto de administración de sistemas que utiliza Docker para montar una pequeña infraestructura compuesta por varios servicios. Cada servicio corre en su propio contenedor, construido desde un Dockerfile propio usando Debian 12 como imagen base. La infraestructura se orquesta con Docker Compose y se gestiona mediante un Makefile.

## Instrucciones

### Requisitos previos

- Una máquina virtual con Debian o una distribución Linux similar
- Docker y el plugin de Docker Compose instalados
- Git y Make instalados

### Instalación

```bash
git clone <repository-url>
cd inception
make
```

`make` se encarga de:
1. Añadir `jpuerto-.42.fr` al fichero `/etc/hosts`
2. Crear los directorios de datos para los volúmenes
3. Construir todas las imágenes Docker
4. Levantar todos los contenedores

### Acceso

- **WordPress**: https://jpuerto-.42.fr
- **WordPress Admin**: https://jpuerto-.42.fr/wp-admin
- **Sitio estático**: http://jpuerto-.42.fr:8080
- **Adminer**: http://jpuerto-.42.fr:8081
- **Portainer**: http://jpuerto-.42.fr:8082

## Recursos

- [Documentación de Docker](https://docs.docker.com/)
- [Documentación de Docker Compose](https://docs.docker.com/compose/)
- [Documentación de WordPress CLI](https://developer.wordpress.org/cli/commands/)
- [Documentación de NGINX](https://nginx.org/en/docs/)
- [Documentación de MariaDB](https://mariadb.com/kb/en/documentation/)

### Uso de IA

La IA se usó como herramienta de apoyo para:
- Entender y construir ficheros de configuración y dependencias entre contenedores
- Debuggear problemas de configuración
- Traducir y dar formato a la documentación

Todo el contenido generado se revisó y se comprendió antes de incluirlo en el proyecto.

## Descripción del proyecto

### Arquitectura

El proyecto consta de los siguientes servicios, cada uno corriendo en su propio contenedor:

**Obligatorios:**
- **NGINX** — Proxy inverso, único punto de entrada vía HTTPS (puerto 443)
- **WordPress + php-fpm** — Gestor de contenidos (puerto 9000, interno)
- **MariaDB** — Servidor de base de datos (puerto 3306, interno)

**Bonus:**
- **Redis** — Caché de objetos para WordPress
- **FTP** — Acceso a ficheros del volumen de WordPress (puerto 21)
- **Sitio estático** — Web HTML servida por NGINX (puerto 8080)
- **Adminer** — Interfaz web para gestionar la base de datos (puerto 8081)
- **Portainer** — Interfaz web para gestionar Docker (puerto 8082)

### Decisiones de diseño

Todas las imágenes se construyen a partir de `debian:12` (la penúltima estable). No se usan imágenes preconstruidas de DockerHub. Las contraseñas se almacenan usando Docker secrets, no variables de entorno.

### Máquina virtual vs Docker

| | Máquina virtual | Docker |
|---|---|---|
| **Aislamiento** | Sistema operativo completo con su propio kernel | Comparte el kernel del host, procesos aislados |
| **Tamaño** | Gigabytes (SO completo) | Megabytes (solo aplicación y dependencias) |
| **Arranque** | Minutos | Segundos |
| **Recursos** | Pesado (CPU, RAM dedicada) | Ligero (recursos compartidos) |
| **Caso de uso** | Necesitas aislar todo el SO | Aislar y desplegar aplicaciones |

Las VMs virtualizan el hardware y ejecutan un SO completo. Docker virtualiza el SO y ejecuta procesos aislados. Docker es más rápido y ligero pero ofrece menos aislamiento.

### Secrets vs variables de entorno

| | Secrets | Variables de entorno |
|---|---|---|
| **Almacenamiento** | Ficheros montados en `/run/secrets/` | Disponibles en el entorno del proceso |
| **Visibilidad** | Solo accesibles dentro del contenedor | Visibles con `docker inspect` |
| **Seguridad** | Más seguros, no aparecen en logs | Pueden filtrarse en logs o al hacer inspect |
| **Caso de uso** | Contraseñas, API keys | Configuración (dominio, nombres de usuario) |

Este proyecto usa secrets para las contraseñas y variables de entorno para la configuración no sensible.

### Red Docker vs red del host

| | Red Docker (bridge) | Red del host |
|---|---|---|
| **Aislamiento** | Contenedores en una red aislada | Contenedores comparten la red del host |
| **Comunicación** | Por nombre de contenedor (DNS) | Por localhost y puertos |
| **Seguridad** | Los contenedores no se exponen por defecto | Todos los puertos se exponen al host |
| **Mapeo de puertos** | Explícito con `ports:` | No hace falta |

Este proyecto usa una red bridge llamada `inception`. Los contenedores se comunican por nombre (por ejemplo, WordPress se conecta a `mariadb`). Solo NGINX expone el puerto 443 al exterior.

### Volúmenes Docker vs bind mounts

| | Volúmenes Docker | Bind mounts |
|---|---|---|
| **Gestión** | Gestionados por Docker | Ruta directa en el host |
| **Portabilidad** | Más portables | Dependen de la ruta del host |
| **Rendimiento** | Optimizado por Docker | Filesystem nativo |
| **Backup** | Mediante comandos de Docker | Acceso directo a ficheros |

Este proyecto usa volúmenes con nombre con `driver_opts` para mapearlos a directorios específicos del host (`/home/jpuerto-/data/`), combinando lo mejor de ambos enfoques.
