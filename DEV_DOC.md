# Documentacion de Desarrollador

## Configurar el entorno desde cero

### Requisitos previos

Instalar en la Maquina Virtual:
```bash
sudo apt-get update
sudo apt-get install -y docker.io docker-compose-plugin git make
```

### Archivos de configuracion

| Archivo | Para que sirve |
|---------|----------------|
| `srcs/.env` | Variables de entorno no sensibles (dominio, usuarios, emails) |
| `srcs/docker-compose.yml` | Definicion de servicios, volumenes, redes y secrets |
| `Makefile` | Comandos de construccion y gestion |

### Secrets

Crear los archivos de contraseñas en el directorio `secrets/`:
```bash
echo "tu_contraseña_db" > secrets/db_password.txt
echo "tu_contraseña_root" > secrets/db_root_password.txt
echo "tu_contraseña_wp_admin" > secrets/wp_admin_password.txt
echo "tu_contraseña_wp_editor" > secrets/wp_user_password.txt
echo "tu_contraseña_ftp" > secrets/ftp_password.txt
```

Estos archivos estan en `.gitignore` y hay que crearlos manualmente en cada maquina nueva.

## Construir y lanzar con Makefile y Docker Compose

| Comando | Descripcion |
|---------|-------------|
| `make` | Setup completo: configura hosts, crea directorios, construye imagenes, levanta contenedores |
| `make setup` | Configura /etc/hosts y crea directorios de datos |
| `make build` | Construye todas las imagenes Docker |
| `make up` | Levanta todos los contenedores en segundo plano |
| `make down` | Para y elimina los contenedores |
| `make clean` | Para contenedores y borra volumenes |
| `make fclean` | Borra todo: contenedores, volumenes, datos e imagenes |
| `make re` | Limpieza completa y reconstruccion |

### Primer lanzamiento

```bash
git clone <url-del-repositorio>
cd inception
# Crear archivos en secrets/ (ver arriba)
# Editar srcs/.env si es necesario
make
```

## Comandos para gestionar contenedores y volumenes

### Contenedores

| Comando | Descripcion |
|---------|-------------|
| `sudo docker ps` | Lista contenedores corriendo |
| `sudo docker ps -a` | Lista todos los contenedores incluyendo parados |
| `sudo docker logs <contenedor>` | Ver logs de un contenedor |
| `sudo docker logs -f <contenedor>` | Seguir logs en tiempo real |
| `sudo docker exec -it <contenedor> bash` | Abrir terminal dentro del contenedor |
| `sudo docker inspect <contenedor>` | Mostrar configuracion del contenedor |

### Volumenes

| Comando | Descripcion |
|---------|-------------|
| `sudo docker volume ls` | Lista todos los volumenes |
| `sudo docker volume inspect <volumen>` | Muestra detalles del volumen |

### Red

| Comando | Descripcion |
|---------|-------------|
| `sudo docker network ls` | Lista todas las redes |
| `sudo docker network inspect srcs_inception` | Muestra detalles de la red |

### Reconstruir un solo servicio

```bash
sudo docker compose -f srcs/docker-compose.yml build <servicio>
sudo docker compose -f srcs/docker-compose.yml up -d <servicio>
```

## Donde se guardan los datos

Los datos persisten en volumenes Docker mapeados a directorios del host:

| Volumen | Ruta en contenedor | Ruta en host |
|---------|-------------------|--------------|
| mariadb | /var/lib/mysql | /home/jpuerto-/data/mariadb |
| wordpress | /var/www/html | /home/jpuerto-/data/wordpress |

Estos directorios sobreviven a `make down` y `make up`. Solo `make fclean` los borra.

### Secrets en tiempo de ejecucion

Dentro de los contenedores, los secrets se montan como archivos en `/run/secrets/`:
- `/run/secrets/db_password`
- `/run/secrets/db_root_password`
- `/run/secrets/wp_admin_password`
- `/run/secrets/wp_user_password`
- `/run/secrets/ftp_password`
