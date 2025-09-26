DOCKER_COMPOSE=docker compose
DOCKER_COMPOSE_FILE=./srcs/docker-compose.yml
LOGIN=jpuerto

.PHONY: kill build down clean re set-login fclean

build: set-login
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up --build

set-login:
	sudo -v; \
	sudo sysctl vm.overcommit_memory=1; \
	if ! grep -q "${LOGIN}.42.fr" /etc/hosts; then \
		echo "Añadiendo ${LOGIN}.42.fr a /etc/hosts"; \
		echo "127.0.0.1 ${LOGIN}.42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi; \
	echo "Creando directorios para los volúmenes..."; \
	sudo mkdir -p /home/jpuerto/data/mariadb; \
	sudo mkdir -p /home/jpuerto/data/wordpress

kill:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) kill

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

clean:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	@echo "Borrando directorios de volumenes..."
	@sudo -v
	sudo rm -rf /home/jpuerto/data/mariadb; \
	sudo rm -rf /home/jpuerto/data/wordpress
	@docker system prune -a -f

re: clean build