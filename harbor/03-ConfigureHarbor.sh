export domain="h2o-4-18157.h2o.vmware.com"

mkdir -p /data/cert
cp ${domain}.crt /data/cert/
cp ${domain}.key /data/cert/

openssl x509 -inform PEM -in ${domain}.crt -out ${domain}.cert

mkdir -p /etc/docker/certs.d/${domain}/
cp ${domain}.cert /etc/docker/certs.d/${domain}/
cp ${domain}.key /etc/docker/certs.d/${domain}/
cp ca.crt /etc/docker/certs.d/${domain}/

find /etc/docker/certs.d/${domain}/ -ls