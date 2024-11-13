#syntax=docker/dockerfile:1
FROM debian:11.11

RUN apt-get -y update && apt-get -y upgrade \
	&& apt-get -y install nginx openssl
#update the package lists
#install the nginx server and the openssl package

COPY ./tools/setup_ssl.sh /usr/local/bin/setup_ssl.sh
# Copy the script to generate the SSL certificates to the /usr/local/bin directory

RUN chmod +x /usr/local/bin/setup_ssl.sh && /usr/local/bin/setup_ssl.sh
# Donner les permissions d’exécution au script et l’exécuter pour générer les certificats

COPY ./conf/nginx.conf /etc/nginx/conf.d
#copy the nginx configuration file to the nginx configuration directory

RUN mkdir -p /run/nginx
#make a directory to store the nginx pid(Process IDentifier) file and the socket file. This directory is not persistent and have to be recreated everytime the container starts

CMD ["nginx", "-g", "daemon off;"]
#RUN is used to execute a command when the image is built, CMD is used to execute a command when the container starts
#nginx is the command to start the nginx server
#-g is used to pass a global directive to the nginx configuration
#daemon off is the global directive to empeach the nginx server to run in background so it will run in the foreground
#it is important to run the nginx server in the foreground because the container will stop if the main process stops