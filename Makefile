# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: ageiser <marvin@42.fr>                     +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/10/15 12:40:03 by ageiser           #+#    #+#              #
#    Updated: 2024/10/15 12:40:10 by ageiser          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

RED = \033[1;31m
GREEN = \033[1;32m
RESET = \033[0m

ifneq (, $(wildcard srcs/requirements/tools/path.txt))  #check if path.txt exists, if it exists, assign the path to dir_path, variable coantains the cat of the path, ssignation of the path to wordpress_dir and mariadb_dir
	dir_path := srcs/requirements/tools/path.txt            
	variable := $(shell cat ${dir_path})
	ifneq ($(variable),)
		wordpress_dir := $(variable)/wordpress
		mariadb_dir := $(variable)/mariadb
	endif
endif

all:
	@if [ ! -f srcs/requirements/tools/path.txt ]; then \
		bash ./srcs/requirements/tools/set.sh; \
		echo "$(GREEN)Everything is set up!$(RESET)"; \
		echo "Please run make to start the server"; \
	elif [ -z "$(variable)" ]; then \
		echo "$(RED)ERROR: empty path$(RESET)"; \
		exit 1; \
	else \

	if [ ! -d "$(mariadb_dir)" ]; then \
			echo "Creating $(mariadb_dir)..."; \
			sudo mkdir -p $(mariadb_dir); \
			sudo chmod 777 $(mariadb_dir); \
	fi; \
	if [ ! -d "$(wordpress_dir)" ]; then \
			echo "Creating $(wordpress_dir)..."; \
			sudo mkdir -p $(wordpress_dir); \
			sudo chmod 777 $(wordpress_dir); \
	fi; \
	echo "$(GREEN)Starting the server...$(RESET)"; \
	sleep 1; \
	sudo docker-compose -f ./srcs/docker-compose.yml up -d --build; \
fi

up : 
	@echo "$(GREEN)Start the server and mount the volumes...$(RESET)"
	@sudo docker-compose -f ./srcs/docker-compose.yml up -d
#launch ther docker container defined in the docker-compose.yml file
# -d flag is for detached mode, it will run the containers in the background
# to test without @

down : 
	@echo "$(RED)Stop the server and unmount the volumes...$(RESET)"
	@sudo docker-compose -f ./srcs/docker-compose.yml down
#stop and remove the containers defined in the docker-compose.yml file

start :
	@echo "$(GREEN)Starting the server...$(RESET)"
	@sudo docker-compose -f ./srcs/docker-compose.yml start
#restart the containers that have been stopped by stop, containers and volumes reusued

stop : 
	@echo "$(RED)Stopping the server...$(RESET)"
	@sudo docker-compose -f ./srcs/docker-compose.yml stop
#stop the containers without removing containers and volumes

fclean:
	@echo "$(RED)Removing the server...$(RESET)"
	@if [ ! -z "$(mariadb_dir)" ]; then \
		sudo rm -rf $(mariadb_dir); \
	fi
	@if [ ! -z "$(wordpress_dir)" ]; then \
		sudo rm -rf $(wordpress_dir); \
	fi
	if [ -f srcs/requirements/tools/path.txt ]; then \
		sudo rm ./srcs/requirements/tools/path.txt; \
	fi
	@sudo docker system prune -af 
#prune, remove all stopped containers, all networks not used by at least one container, all dangling images, all build cache

re: fclean all

reset: clean
	@echo "$(GREEN)Resetting the server...$(RESET)"
	@rm ./srcs/requirements/tools/path.txt
	@printf "\nPath has been reset\n"


status : 
	@sudo docker ps
#list all running containers

.PHONY: all up down start stop fclean reset re status

