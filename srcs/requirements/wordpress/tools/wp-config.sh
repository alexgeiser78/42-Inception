#!/bin/bash


if [ -f ./wp-config.php ]; then
	echo -e "\033[0;31mWordPress is already installed\033[0m"
else
	wp core download --allow-root
	wp config create --allow-root \
		--dbname=$MYSQL_DATABASE \
		--dbuser=$MYSQL_USER \
		--dbpass=$MYSQL_PASSWORD \
		--dbhost=mariadb \
		--extra-php <<PHP
	define( 'WP_HOME', 'https://$DOMAIN_NAME' );
	define( 'WP_SITEURL', 'https://$DOMAIN_NAME' );
	define( 'WP_DEBUG', true );
	define( 'WP_DEBUG_LOG', true );
	define( 'WP_DEBUG_DISPLAY', false );
	PHP
	wp core install --url=$DOMAIN_NAME \
		--title="$SITE_TITLE" \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PASSWORD \
		--admin_email=$ADMIN_EMAIL \
		--skip-email \
		--allow-root
	wp user create --allow-root \
		$USER_NAME \
		$USER_EMAIL \
		--user_pass=$USER_PASSWORD \
		--role=author
	wp theme install --allow-root \
		--activate \
		rainfall
	echo -e "\033[0;32mwp-config.php file created\033[0m"
fi

if [ ! -d /run/php ]
then
	echo -e "\033[0;32mCreating /run/php directory\033[0m"
	mkdir -p /run/php
	chmod 755 /run/php
else
	echo -e "\033[0;31m/run/php directory already exists\033[0m"
fi


/usr/sbin/php-fpm7.4 -F

#2 we have to use bash to run the script
#4 check if the default config file exists in folder /var/www/html
#7 use the wp-cli to download the latest version of wordpress with root privileges
#8 create the wp-config.php file with the following parameters
#9 -- is the flag to pass the parameter
#12 the host is the name of the service in the docker-compose file
#13 define the domain name of the website
#18 skip the email verification of installation
#20 create a new user with the following parameters
#24 also: administrator(total control of the website), editor(supervisor of the content created by him or author), author(only write and publish his own posts), contributor(only write posts but can't publish), subscriber(only read posts)
#25 install the theme Rainfall
#31 check if the directory /run/php doesn't exists
#34 create the directory /run/php
#35 change the permissions of the directory
#41   #start the php-fpm service with the version 8.3 of php, -F means that PHP-FPM will not daemonize, and will stay in the foreground until the process is killed.