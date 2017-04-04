#/bin/bash

yum -y install ca-certificates openssl && yum clean all
update-ca-trust force-enable

. /etc/os-release
if   [ "$ID" = "centos" ]; then
	CADIR="/etcpki/ca-trus-source/anchors"
elif [ "$ID" = "ubuntu" ]; then
	CADIR="/usr/local/share/ca-certificates"
else
	echo "$0: ERROR: UNKNOWN OS '$ID'"
	exit 1
fi

mkdir -p $CADIR

if [ "$CA" ]; then
	echo "Add certificate to trusted CA from ENV.CA"
	echo "$CA" > $CADIR/ca.crt
	openssl x509 -in $CADIR/ca.crt -noout -subject -dates
fi
i=1
while [ -n "$1" ]; do
	fn="ca$i.crt"
	echo "Add certificate to trusted CA from argument $i.$fn = '$1'"
	echo "$1" > $CADIR/$fn
	openssl x509 -in $CADIR/$fn -noout -subject -dates
	cp $fn $CADIR/
	shift
	i=$[[ $i + 1 ]]
done
for crt in $(ls -1 /*crt); do
	echo "Add certificate to trusted CA from file '$crt'"
	openssl x509 -in $crt -noout -subject -dates
	cp $crt $CADIR/
done
update-ca-certificates

exit 0