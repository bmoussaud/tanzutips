set -x
export customer="altice"
export domain="h2o-4-18157.h2o.vmware.com"

echo "Generate a CA certificate private key."
openssl genrsa -out ca.key 4096

echo "Generate the CA certificate."
openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=CN/ST=France/L=Paris/O=${customer}/OU=Personal/CN=${domain}" \
 -key ca.key \
 -out ca.crt

 ls -l ca.key ca.crt