DOCKER_COMPOSE = sudo docker compose
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml
LOGIN = jpuerto-
DATA_DIR = /home/$(LOGIN)/data

.PHONY: all setup build up down stop start restart logs clean fclean re

all: setup build up

setup:
	@sudo sysctl vm.overcommit_memory=1
	@if ! grep -q "$(LOGIN).42.fr" /etc/hosts; then \
		echo "127.0.0.1 $(LOGIN).42.fr" | sudo tee -a /etc/hosts > /dev/null; \
	fi
	@sudo mkdir -p $(DATA_DIR)/mariadb
	@sudo mkdir -p $(DATA_DIR)/wordpress

build:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

up:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

down:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

stop:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) stop

start:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) start

restart:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) restart

logs:
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) logs -f

clean: down
	@$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down -v

fclean: clean
	@sudo rm -rf $(DATA_DIR)
	@sudo docker system prune -af

re: fclean all
