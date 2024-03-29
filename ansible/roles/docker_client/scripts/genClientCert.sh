#!/bin/bash

if [[ $1 = '' ]]; then
  echo 'script requires a client name'
  exit 1
fi
CLIENT=./certs/$1

echo 'WARN: hard coded alpha-api-old gamma-services and beta-services for SWARM'
if [[ $2 = '' ]]; then
  echo 'script requires a client ip address'
  exit 1
fi

mkdir $CLIENT

# generate key for client
openssl genrsa -out "$CLIENT/key.pem" 2048
chmod 400 "$CLIENT/key.pem"

# generate CSR for client
openssl req \
  -subj '/CN=client' \
  -new \
  -key "$CLIENT/key.pem" \
  -out "$CLIENT/client.csr"

chmod 400 "$CLIENT/client.csr"

echo extendedKeyUsage=clientAuth,serverAuth > "$CLIENT/extfile.cnf"
echo subjectAltName=IP:$2 >> "$CLIENT/extfile.cnf"

# generate cert for client
openssl x509 \
  -req \
  -days 365 \
  -sha256 \
  -in "$CLIENT/client.csr" \
  -CA ./certs/ca.pem \
  -CAkey ./certs/ca-key.pem \
  -passin file:./certs/pass \
  -CAcreateserial \
  -out "$CLIENT/cert.pem" \
  -extfile "$CLIENT/extfile.cnf"

# set permissions for deploy
chmod 644 "$CLIENT/cert.pem"
chmod 644 "$CLIENT/key.pem"

# cleanup files we do not need
rm $CLIENT/extfile.cnf
rm -f $CLIENT/client.csr
