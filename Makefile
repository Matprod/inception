# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: matprod <matprod@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/01/01 12:00:00 by matprod           #+#    #+#              #
#    Updated: 2024/01/01 12:00:00 by matprod          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors
GREEN		= \033[0;32m
YELLOW		= \033[0;33m
RED			= \033[0;31m
BLUE		= \033[0;34m
NC			= \033[0m # No Color

# Variables
DOCKER_COMPOSE = docker compose
SRCS_DIR = srcs

.PHONY: all build up down restart logs clean fclean re setup

all: setup build up

setup:
	@echo "$(BLUE)Setting up directories...$(NC)"
	@mkdir -p /home/matprod/data/wordpress
	@mkdir -p /home/matprod/data/mariadb
	@echo "$(GREEN)Directories created successfully!$(NC)"

build:
	@echo "$(BLUE)Building Docker images...$(NC)"
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) build --no-cache
	@echo "$(GREEN)Docker images built successfully!$(NC)"

up:
	@echo "$(BLUE)Starting containers...$(NC)"
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)Containers started successfully!$(NC)"

down:
	@echo "$(YELLOW)Stopping containers...$(NC)"
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) down
	@echo "$(GREEN)Containers stopped successfully!$(NC)"

restart: down up

logs:
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) logs -f

clean:
	@echo "$(YELLOW)Cleaning up containers and volumes...$(NC)"
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) down -v
	@docker system prune -f
	@echo "$(GREEN)Clean completed!$(NC)"

fclean: clean
	@echo "$(RED)Force cleaning everything...$(NC)"
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) down -v --rmi all
	@docker system prune -af
	@sudo rm -rf /home/matprod/data
	@echo "$(GREEN)Force clean completed!$(NC)"

re: fclean all

status:
	@echo "$(BLUE)Container status:$(NC)"
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) ps

# Individual service management
nginx-logs:
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) logs nginx

wordpress-logs:
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) logs wordpress

mariadb-logs:
	@cd $(SRCS_DIR) && $(DOCKER_COMPOSE) logs mariadb

# Help
help:
	@echo "$(BLUE)Available commands:$(NC)"
	@echo "  all          - Setup, build and start all services"
	@echo "  build        - Build Docker images"
	@echo "  up           - Start all containers"
	@echo "  down         - Stop all containers"
	@echo "  restart      - Restart all containers"
	@echo "  logs         - Show logs for all services"
	@echo "  clean        - Stop containers and clean up"
	@echo "  fclean       - Remove everything (images, volumes, data)"
	@echo "  re           - Full rebuild"
	@echo "  status       - Show container status"
	@echo "  nginx-logs   - Show NGINX logs"
	@echo "  wordpress-logs - Show WordPress logs"
	@echo "  mariadb-logs - Show MariaDB logs"
	@echo "  help         - Show this help message"
