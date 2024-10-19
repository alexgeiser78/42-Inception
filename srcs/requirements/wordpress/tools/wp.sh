#!/bin/bash  
# we have to unse bash to run the script

if [ -f ./wp-config.php ] # check if the default config file exists in folder /var/www/html
then
	echo -e "\033[0;31mWordPress is already installed\033[0m"
else
	wp core download --allow-root    #use the wp-cli to download the latest version of wordpress with root privileges
	wp config create --allow-root \  #create the wp-config.php file with the following parameters 
		--dbname=$MYSQL_DATABASE \   #-- is the flag to pass the parameter
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb    	     #the host is the name of the service in the docker-compose file
	wp core install --url=$DOMAIN_NAME \  #define the domain name of the website
		--title="$SITE_TITLE" \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--skip-email \                   #skip the email verification of installation
		--allow-root
	wp user create --allow-root \      #create a new user with the following parameters
		$USER_NAME \
		$USER_EMAIL \
		--user_pass=$USER_PASSWORD \
		--role=author                  #also: administrator(total control of the website), editor(supervisor of the content created by him or author), author(only write and publish his own posts), contributor(only write posts but can't publish), subscriber(only read posts)
	wp theme install --allow-root \     #install the theme Rainfall
		--activate \
		Rainfall
	echo -e "\033[0;32mwp-config.php file created\033[0m"
fi

if [ ! -d /run/php ] #check if the directory /run/php doesn't exists
then
	echo -e "\033[0;32mCreating /run/php directory\033[0m"
	mkdir -p /run/php  # create the directory /run/php
	chmod 755 /run/php  #change the permissions of the directory
else
	echo -e "\033[0;31m/run/php directory already exists\033[0m"
fi


/usr/sbin/php-fpm8.3 -F  #start the php-fpm service with the version 8.3 of php, -F means that PHP-FPM will not daemonize, and will stay in the foreground until the process is killed.