#/bin/bash

# add-trusted-certificates.sh
#
# export to ca-trust X509 certificates
# they can be assigned to CA environment variable
# or passed as arguments "....PEM.FORMAT..." "....PEM...." ...
#
# you can also use a CHECK_CURL (environment variable) = url to check

usage() {
	cat - 1>&2 <<EOF;
Usage: $0 options -- arguments

with options:
-d    for debug
-c "curl URL to check"

with arguments:
"...X509.PEM..." ...

IMPORTANT: always add '--' before inserting your certificates, otherwise the '------' used by PEM format will be badly interpreted by getopt

EOF
	exit 1; 
}

CHECK_CURL="$CHECK_CURL"

while getopts "d+c:" o; do
    case "${o}" in
        d)
			set -x
            ;;
        c)
            CHECK_CURL="${OPTARG}"
			echo "set CHECK_CURL=\"$CHECK_CURL\""
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

yum -y install ca-certificates openssl && yum clean all

. /etc/os-release
if   [ "$ID" = "centos" ]; then
	CADIR="/etc/pki/ca-trust/source/anchors"
	update-ca-trust force-enable
	UPDATE_CA_COMMAND="update-ca-trust"
elif [ "$ID" = "ubuntu" ]; then
	CADIR="/usr/local/share/ca-certificates"
	UPDATE_CA_COMMAND="update-ca-certificates"
else
	echo "$0: ERROR: UNKNOWN OS '$ID'"
	exit 1
fi

mkdir -p $CADIR

if [ "$CA" ]; then
	echo "Add certificate to trusted CA from ENV.CA"
	echo "$CA"  |sed 's/BEGIN CERTIFICATE/BEGIN_CERTIFICATE/g' | sed 's/END CERTIFICATE/END_CERTIFICATE/g' | sed 's/ /\n/g' | sed 's/BEGIN_CERTIFICATE/BEGIN CERTIFICATE/g' | sed 's/END_CERTIFICATE/END CERTIFICATE/g' > $CADIR/ca.crt
	openssl x509 -in $CADIR/ca.crt -noout -subject -dates
fi
i=1
while [ -n "$1" ]; do
	fn="ca$i.crt"
	echo "Add certificate to trusted CA from argument $i.$fn = '$1'"
	echo "$1" |sed 's/BEGIN CERTIFICATE/BEGIN_CERTIFICATE/g' | sed 's/END CERTIFICATE/END_CERTIFICATE/g' | sed 's/ /\n/g' | sed 's/BEGIN_CERTIFICATE/BEGIN CERTIFICATE/g' | sed 's/END_CERTIFICATE/END CERTIFICATE/g' > $CADIR/$fn
	openssl x509 -in $CADIR/$fn -noout -subject -dates
	shift
	i=$[ $i + 1 ]
done
# for crt in $(ls -1 /*crt); do
	# echo "Add certificate to trusted CA from file '$crt'"
	# openssl x509 -in $crt -noout -subject -dates
	# cp $crt $CADIR/
# done
$UPDATE_CA_COMMAND

if [ -n "$CHECK_CURL" ]; then
	set -x
	curl -v "$CHECK_CURL"
	if [ $? != 0 ]; then
		echo "curl check failed! '$CHECK_CURL'"
		exit 2
	fi
fi

exit 0