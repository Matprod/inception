# Colors for output
GREEN = \033[32m
YELLOW = \033[33m
RED = \033[31m
BLUE = \033[34m
RESET = \033[0m

# Configuration
DOCKER_COMPOSE_FILE = ./srcs/docker-compose.yml

# Build and start containers
all: build up

# Setup directories and permissions
setup-dirs:
	@printf "$(GREEN)[+] Creating volumes' directories...$(RESET)\n"
	@sudo mkdir -p /home/matprod/data/mysql
	@sudo mkdir -p /home/matprod/data/wordpress
	@sudo chmod 777 /home/matprod/data/mysql
	@sudo chmod 777 /home/matprod/data/wordpress

# Start containers
up: setup-dirs
	@printf "$(GREEN)[+] Starting containers...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) up -d --build
	@printf "$(GREEN)[+] Containers started.$(RESET)\n"


# Stop containers
down:
	@printf "$(YELLOW)[+] Stopping containers...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) down
	@printf "$(GREEN)[+] Containers stopped.$(RESET)\n"

# Restart containers
restart: down up

# Build images
build:
	@printf "$(GREEN)[+] Building images...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) build --no-cache
	@printf "$(GREEN)[+] Images built.$(RESET)\n"

# Show logs
logs:
	@docker compose -f $(DOCKER_COMPOSE_FILE) logs -f

# Show container status
status:
	@printf "$(BLUE)[+] Container Status:$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) ps

# Clean containers and images
clean:
	@printf "$(YELLOW)[+] Stopping containers...$(RESET)\n"
	@docker compose -f $(DOCKER_COMPOSE_FILE) down -v
	@printf "$(GREEN)[+] Containers stopped.$(RESET)\n"
	@printf "$(YELLOW)[+] Removing images...$(RESET)\n"
	@docker rmi -f $$(docker images -q) 2>/dev/null || true
	@printf "$(GREEN)[+] Images removed.$(RESET)\n"

# Full clean (containers, images, volumes, networks)
fclean: clean
	@printf "$(RED)[+] Full cleanup...$(RESET)\n"
	@docker system prune -af --volumes
	@sudo rm -rf /home/matprod/data/mysql/* /home/matprod/data/wordpress/*
	@printf "$(GREEN)[+] Full cleanup completed.$(RESET)\n"

volume:
	@printf "$(BLUE)[+] Docker Volumes:$(RESET)\n"
	@docker volume ls

.PHONY: up down restart build all logs status volume clean fclean setup-dirs