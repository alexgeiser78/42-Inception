#!/bin/bash

mkdir -p /etc/nginx/ssl
#Create a directory to store the certificate and the private key

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
