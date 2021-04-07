# Ref: http://theblasfrompas.blogspot.com/2020/05/creating-my-first-tanzu-kubernetes-grid.html
# Ref: https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file

# tested TKG 13/AWS
# dependencies : bash, tanzu , envsubst, aws cli

export AWS_DEFAULT_REGION=eu-west-3

if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
    echo "please provide AWS_ACCESS_KEY_ID"
    exit 1
fi

if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
    echo "please provide AWS_SECRET_ACCESS_KEY"
    exit 1
fi

export AWS_B64ENCODED_CREDENTIALS=$(cat <<EOF | base64 
[default]
aws_access_key_id = ${AWS_ACCESS_KEY_ID}
aws_secret_access_key = ${AWS_SECRET_ACCESS_KEY}
EOF
)

envsubst < ./aws-management-cluster-template.yaml | grep -v '""' | grep -v "#" > aws-management-cluster.yaml

echo "create the EC2 key pair tkg-${AWS_DEFAULT_REGION}"
aws ec2 create-key-pair --key-name tkg-${AWS_DEFAULT_REGION}

echo "create the AWS roles"
tanzu management-cluster permissions aws set -f aws-management-cluster.yaml

echo "create the cluster"
tanzu management-cluster create --file aws-management-cluster.yaml -v 6

