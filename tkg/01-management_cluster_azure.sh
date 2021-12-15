# Ref: http://theblasfrompas.blogspot.com/2020/05/creating-my-first-tanzu-kubernetes-grid.html
# Ref: https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file

# tested TKG 14/AZURE
# dependencies : bash, tanzu , envsubst, aws cli

export AZURE_LOCATION=francecentral
export CLUSTER_NAME=${CLUSTER_NAME:-bmoussaud-az-paris-mgt-cluster}
export CLUSTER_RG=tkg-paris

if [[ -z "${AZURE_SUBSCRIPTION_ID}" ]]; then
    echo "please provide AZURE_SUBSCRIPTION_ID"
    exit 1
fi

if [[ -z "${AZURE_TENANT_ID}" ]]; then
    echo "please provide AZURE_TENANT_ID"
    exit 1
fi

if [[ -z "${AZURE_CLIENT_ID}" ]]; then
    echo "please provide AZURE_CLIENT_ID"
    exit 1
fi

if [[ -z "${AZURE_CLIENT_SECRET}" ]]; then
    echo "please provide AZURE_CLIENT_SECRET"
    exit 1
fi

export AZURE_SSH_PUBLIC_KEY_B64=$(cat ~/.ssh/id_rsa.pub | awk {'print $1,$2'} | base64)

envsubst < ./azure-management-cluster-template.yaml | grep -v '""' | grep -v "#" | sort > azure-management-cluster.yaml


cat azure-management-cluster.yaml

echo "create the management cluster"
tanzu management-cluster create --file azure-management-cluster.yaml -v 6 

