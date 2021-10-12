# Ref: http://theblasfrompas.blogspot.com/2020/05/creating-my-first-tanzu-kubernetes-grid.html
# Ref: https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file

# tested TKG 13/AWS
# dependencies : bash, tanzu , envsubst, 
# CloudGate -> PowerUser
export AWS_DEFAULT_REGION=${AWS_DEFAULT_REGION:-eu-west-3}
export CLUSTER_NAME=${CLUSTER_NAME:-aws-one}
export K8S_VERSION=${K8S_VERSION:-v1.20.4---vmware.1-tkg.2}

if [[ -z "${AWS_ACCESS_KEY_ID}" ]]; then
    echo "please provide AWS_ACCESS_KEY_ID"
    exit 1
fi

if [[ -z "${AWS_SECRET_ACCESS_KEY}" ]]; then
    echo "please provide AWS_SECRET_ACCESS_KEY"
    exit 1
fi

envsubst < ./aws-cluster-template.yaml  | grep -v "#" > aws-cluster.yaml

echo "create the cluster ${CLUSTER_NAME}"
cat aws-cluster.yaml

#tanzu cluster create --file aws-cluster.yaml --verbose 9 --tkr ${K8S_VERSION} 
tanzu cluster create --file aws-cluster.yaml --verbose 9 

