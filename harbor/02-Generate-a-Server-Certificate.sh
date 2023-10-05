export domain="h2o-4-18157.h2o.vmware.com"
export customer="altice"
export hostname="harbor2"
export harborip="10.214.182.91"

echo "Generate a private key"
openssl genrsa -out ${domain}.key 4096

echo "Generate a certificate signing request (CSR)."
openssl req -sha512 -new -subj "/C=CN/ST=France/L=Paris/O=${customer}/OU=Personal/CN=${domain}" \
    -key ${domain}.key \
    -out ${domain}.csr

echo "Generate an x509 v3 extension file."

cat > v3.ext <<-EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=${domain}
DNS.2=${hostame}
DNS.3=${harborip}
EOF

openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in ${domain}.csr \
    -out ${domain}.crt



