*This project has been created as part of the 42 curriculum by jpuerto-.*

# Inception

## Description

Inception is a system administration project that uses Docker to set up a small infrastructure composed of multiple services. Each service runs in its own container, built from custom Dockerfiles using Debian 12 as the base image. The infrastructure is orchestrated with Docker Compose and managed through a Makefile.

## Instructions

### Prerequisites

- A Virtual Machine with Debian or similar Linux distribution
- Docker and Docker Compose plugin installed
- Git and Make installed

### Installation

```bash
git clone <repository-url>
cd inception
make
```

`make` will:
1. Add `jpuerto-.42.fr` to `/etc/hosts`
2. Create data directories for volumes
3. Build all Docker images
4. Start all containers

### Access

- **WordPress**: https://jpuerto-.42.fr
- **WordPress Admin**: https://jpuerto-.42.fr/wp-admin
- **Static Site**: http://jpuerto-.42.fr:8080
- **Adminer**: http://jpuerto-.42.fr:8081
- **Portainer**: http://jpuerto-.42.fr:8082

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [WordPress CLI Documentation](https://developer.wordpress.org/cli/commands/)
- [NGINX Documentation](https://nginx.org/en/docs/)
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)

### AI Usage

AI was used as a support tool for:
- Understanding and building configuration files and container dependencies
- Debugging configuration issues
- Translating and formatting documentation

All generated content was reviewed and understood before being included in the project.

## Project Description

### Architecture

The project consists of the following services, each running in its own container:

**Mandatory:**
- **NGINX** - Reverse proxy, sole entry point via HTTPS (port 443)
- **WordPress + php-fpm** - Content management system (port 9000, internal)
- **MariaDB** - Database server (port 3306, internal)

**Bonus:**
- **Redis** - Object cache for WordPress
- **FTP** - File access to WordPress volume (port 21)
- **Static Site** - HTML website served by NGINX (port 8080)
- **Adminer** - Database management UI (port 8081)
- **Portainer** - Docker management UI (port 8082)

### Design Choices

All images are built from `debian:12` (penultimate stable). No pre-built images from DockerHub are used. Passwords are stored using Docker secrets, not environment variables.

### Virtual Machines vs Docker

| | Virtual Machine | Docker |
|---|---|---|
| **Isolation** | Full OS with its own kernel | Shares host kernel, isolated processes |
| **Size** | Gigabytes (full OS) | Megabytes (only application and dependencies) |
| **Startup** | Minutes | Seconds |
| **Resources** | Heavy (dedicated CPU, RAM) | Lightweight (shared resources) |
| **Use case** | Full OS isolation needed | Application isolation and deployment |

VMs virtualize hardware and run a complete OS. Docker virtualizes the OS and runs isolated processes. Docker is faster and lighter but provides less isolation.

### Secrets vs Environment Variables

| | Secrets | Environment Variables |
|---|---|---|
| **Storage** | Files mounted in `/run/secrets/` | Available in process environment |
| **Visibility** | Only accessible inside the container | Visible via `docker inspect` |
| **Security** | More secure, not exposed in logs | Can leak in logs or inspect output |
| **Use case** | Passwords, API keys | Configuration (domain, usernames) |

This project uses secrets for passwords and environment variables for non-sensitive configuration.

### Docker Network vs Host Network

| | Docker Network (bridge) | Host Network |
|---|---|---|
| **Isolation** | Containers in isolated network | Containers share host network |
| **Communication** | By container name (DNS) | By localhost and ports |
| **Security** | Containers not exposed by default | All ports exposed to host |
| **Port mapping** | Explicit with `ports:` | Not needed |

This project uses a bridge network called `inception`. Containers communicate by name (e.g., WordPress connects to `mariadb`). Only NGINX exposes port 443 to the outside.

### Docker Volumes vs Bind Mounts

| | Docker Volumes | Bind Mounts |
|---|---|---|
| **Management** | Managed by Docker | Direct host path |
| **Portability** | More portable | Depends on host path |
| **Performance** | Optimized by Docker | Native filesystem |
| **Backup** | Via Docker commands | Direct file access |

This project uses named volumes with `driver_opts` to map to specific host directories (`/home/jpuerto-/data/`), combining the benefits of both approaches.
