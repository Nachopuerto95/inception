# Documentacion de Usuario

## Servicios disponibles

| Servicio | Descripcion | Acceso |
|----------|-------------|--------|
| WordPress | Sistema de gestion de contenidos | https://jpuerto-.42.fr |
| MariaDB | Base de datos de WordPress | Solo interno |
| NGINX | Proxy inverso con SSL | https://jpuerto-.42.fr |
| Redis | Cache para WordPress | Solo interno |
| FTP | Acceso a archivos de WordPress | ftp://jpuerto-.42.fr (puerto 21) |
| Static Site | Web HTML con enlaces a todos los servicios | http://jpuerto-.42.fr:8080 |
| Adminer | Interfaz web para gestionar la base de datos | http://jpuerto-.42.fr:8081 |
| Portainer | Interfaz web para gestionar contenedores Docker | http://jpuerto-.42.fr:8082 |

## Iniciar y parar

Iniciar todo:
```bash
make
```

Parar todo:
```bash
make down
```

Reiniciar:
```bash
make restart
```

Limpiar todo y reconstruir:
```bash
make re
```

## Acceder a la web

### WordPress
Abrir https://jpuerto-.42.fr en el navegador. Aceptar la advertencia del certificado autofirmado.

### Panel de administracion
Abrir https://jpuerto-.42.fr/wp-admin e iniciar sesion con:
- **Usuario**: jpuerto-
- **Contraseña**: (ver seccion de credenciales)

### Enlaces rapidos
Abrir http://jpuerto-.42.fr:8080 para ver el sitio estatico con enlaces a todos los servicios.

## Credenciales

Las contraseñas estan en el directorio `secrets/`. Cada archivo contiene una contraseña:

| Archivo | Para que sirve |
|---------|----------------|
| `secrets/db_password.txt` | Contraseña del usuario de MariaDB |
| `secrets/db_root_password.txt` | Contraseña de root de MariaDB |
| `secrets/wp_admin_password.txt` | Contraseña del admin de WordPress |
| `secrets/wp_user_password.txt` | Contraseña del editor de WordPress |
| `secrets/ftp_password.txt` | Contraseña del usuario FTP |

La configuracion no sensible (usuarios, dominio, emails) esta en `srcs/.env`.

Para cambiar una contraseña, edita el archivo en `secrets/` y reconstruye:
```bash
make re
```

## Verificar servicios

Ver que todos los contenedores estan corriendo:
```bash
sudo docker ps
```
Todos deben mostrar estado `Up`.

Verificar WordPress:
- Abrir https://jpuerto-.42.fr — debe mostrar la web

Verificar MariaDB:
```bash
sudo docker exec -it mariadb mysql -u jpuerto- -p wordpress -e "SHOW TABLES;"
```

Verificar Redis:
```bash
sudo docker exec wordpress wp redis status --allow-root --path=/var/www/html
```

Verificar FTP:
```bash
ftp jpuerto-.42.fr
```

Verificar SSL/TLS:
```bash
curl -vk https://jpuerto-.42.fr 2>&1 | grep "SSL connection"
```

Verificar que HTTP (puerto 80) no funciona:
```bash
curl http://jpuerto-.42.fr
```
Debe dar error de conexion.
