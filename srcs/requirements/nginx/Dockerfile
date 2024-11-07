#syntax=docker/dockerfile:1
FROM debian:11.11

RUN apt-get -y update && apt-get -y upgrade \
	&& apt-get -y install nginx openssl
#update the package lists
#install the nginx server and the openssl package

RUN mkdir -p /etc/nginx/ssl
#make a directory to store the ssl certificates

RUN openssl req -newkey rsa:4096 \
        -x509 \
        -sha256 \
        -days 365 \
        -nodes \
        -out /etc/nginx/ssl/certificate.crt \
        -keyout /etc/nginx/ssl/certificate.key \
        -subj "/C=ES/ST=BARCELONA/L=BARCELONA/O=42/OU=ageiser/CN=ageiser"
#create a self-signed certificate and a private key
#openssl req is the command to create a certificate request(CSR), automatically signed by the user
#newkey rsa:4096  4096 bits key
#x509 is the format of public key certificates (autosigned)
#sha256 is the hash algorithm used to sign the certificate
#days 365 is the expiration date of the certificate
#nodes is to avoid the password prompt when the certificate is used because you can have a password to protect the certificate
#out is the output file where the certificate will be stored
#keyout is the private key file
#subj is the subject(informations) of the certificate, C=Country, ST=State, L=Locality, O=Organization, OU=Organizational Unit, CN=Common Name

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