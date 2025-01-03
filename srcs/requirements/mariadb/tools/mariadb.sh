#!/bin/bash

mysqld_safe --user=mysql &

until mysqladmin ping --silent; do
    echo "Waiting for database connection..."
    sleep 1
done

if [ ! -d /var/lib/mysql/${MYSQL_DATABASE} ];
then
    echo "mysql setup"
    mysql -u ${MYSQL_ROOT_USER} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE $MYSQL_DATABASE;"
    mysql -e "CREATE USER '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'"
    mysql -e "GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD' WITH GRANT OPTION;"
    mysql -e "FLUSH PRIVILEGES;"
    mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
 fi

    echo "mysql shutdown"
    mysqladmin -u ${MYSQL_ROOT_USER} --password=${MYSQL_ROOT_PASSWORD} shutdown

    exec mysqld --user=mysql --console

#3 start the service
#5 bash infinity loop until the database is connected
#10 check if the database doesn't exists(! -d ), ${MYSQL_DATABASE} = env variable
#13 create the database with the root user and password
#13 -u = user, -p = password, -e = execute
#14 #@'%' = can connect from any ip address
#15 grant all privileges to the user created above and can grant the privileges to other users
#16 reload the privileges
#16 without this, the root user won't have a password or the one by default
#21 mysqladmin = admin tool for mysql, shutdown = shutdown the server
#23 starts the mysql server process