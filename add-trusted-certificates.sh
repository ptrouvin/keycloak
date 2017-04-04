#/bin/bash

mkdir -p /usr/local/share/ca-certificates

if [ "$CA" ]; then
	echo "Add certificate to trusted CA from ENV.CA"
	echo "$CA" > /usr/local/share/ca-certificates/ca.crt
	openssl x509 -in /usr/local/share/ca-certificates/ca.crt -noout -subject -dates
fi
for crt in ls -1 /*crt; do
	echo "Add certificate to trusted CA from file '$crt'"
	openssl x509 -in $crt -noout -subject -dates
	cp $crt /usr/local/share/ca-certificates/
done
update-ca-certificates
