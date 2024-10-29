# syntax=docker/dockerfile:1
# syntax used in this file

FROM debian:bullseye
# the base image is gonna use the debian bullseye image for OS

RUN apt-get update && apt-get install -y \
	mariadb-server && \
	rm -rf /var/lib/apt/lists/*
# mariadb installation
# package update && install mariadb-server without confirmation(-y)
# && remove the package lists to reduce the docker image size

COPY ./conf/mariadb.conf /etc/mysql/mariadb.conf.d/50-server.cnf
# copy the mariadb configuration file to the container
# 50- prefix is used to make sure that the file is loaded after the default configuration file

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 755 /var/run/mysqld
#create a directory where the mariadb server will store the pid file and socket file, -p flag is used to create the parent directories if they don't exist
# && modify the acces rights, -R recursive for all the files and dir, mysql:mysql is the user and group. mariadb need to write in those files and dir
# &&(rwxr-xr-x)

EXPOSE 3306
# the default port of mariadb must be open

COPY ./tools/mariadb.sh /usr/local/bin/mariadb.sh
# copy the script that will start the mariadb server

RUN chmod +x /usr/local/bin/mariadb.sh
# give the execution rights to the script

RUN mysql_install_db
# initialize the base files of the mariadb database by default, prepares the environemnt of mariadb in the container

ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]
# the script will be executed everytime the container starts
