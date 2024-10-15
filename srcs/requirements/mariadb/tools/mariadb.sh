#!/bin/bash

service mysql start; # start the service

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ]; # check if the database doesn't exists(! -d ), ${MYSQL_DATABASE} = env variable
then
    echo "mysql setup"
    mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE $MYSQL_DATABASE;" # create the database with the root user and password
                                                                                               # -u = user, -p = password, -e = execute
    mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'" #@'%' = can connect from any ip address
    mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;" # grant all privileges to the user created above and can grant the privileges to other users
    mysql -e "FLUSH PRIVILEGES;" # reload the privileges
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" # without this, the root user won't have a psssword or the one by default
 fi # end of the if statement

    echo "mysql shutdown"
    mysqladmin -u ${MYSQL_ROOT_USER} --password=${MYSQL_ROOT_PASSWORD} shutdown # mysqladmin = admin tool for mysql, shutdown = shutdown the server

    mysql # starts the mysql server process