#/bin/bash

yum -y install ca-certificates openssl && yum clean all
update-ca-trust force-enable

. /etc/os-release
if   [ "$ID" = "centos" ]; then
	CADIR="/etcpki/ca-trus-source/anchors"
elif [ "$ID" = "ubuntu" ]; then
	CADIR="/usr/local/share/ca-certificates"
fi

mkdir -p $CADIR

if [ "$CA" ]; then
	echo "Add certificate to trusted CA from ENV.CA"
	echo "$CA" > $CADIR/ca.crt
	openssl x509 -in $CADIR/ca.crt -noout -subject -dates
fi
for crt in ls -1 /*crt; do
	echo "Add certificate to trusted CA from file '$crt'"
	openssl x509 -in $crt -noout -subject -dates
	cp $crt $CADIR/
done
update-ca-certificates