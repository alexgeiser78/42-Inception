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


all : up 

up : 
	@docker-compose -f ./srcs/docker-compose.yml up -d
#lauch ther docker container defined in the docker-compose.yml file
# -d flag is for detached mode, it will run the containers in the background
# to test without @

down : 
	@docker-compose -f ./srcs/docker-compose.yml down
#stop and remove the containers defined in the docker-compose.yml file

stop : 
	@docker-compose -f ./srcs/docker-compose.yml stop
#stop the containers without removing containers and volumes

start : 
	@docker-compose -f ./srcs/docker-compose.yml start
#restart the containers that have been stopped by stop, containers and volumes reusued

status : 
	@docker ps
#list all running containers
