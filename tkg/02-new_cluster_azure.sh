# Ref: http://theblasfrompas.blogspot.com/2020/05/creating-my-first-tanzu-kubernetes-grid.html
# Ref: https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file

# tested TKG 13/AZURE
# dependencies : bash, tanzu , envsubst, 
# CloudGate -> PowerUser

set -x
export AZURE_LOCATION=francecentral
export CLUSTER_NAME=${CLUSTER_NAME:-bmoussaud-azure-01}
export AZURE_RG=tkg

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

envsubst < ./azure-cluster-template.yaml  | grep -v "#" > azure-cluster.yaml

echo "create the Network Securiy Group"
#https://docs.microsoft.com/en-us/cli/azure/network/nsg?view=azure-cli-latest#az_network_nsg_create
az login --service-principal --username ${AZURE_CLIENT_ID} --password ${AZURE_CLIENT_SECRET} --tenant ${AZURE_TENANT_ID} 
az network nsg create --resource-group ${AZURE_RG} --name ${CLUSTER_NAME}-node-nsg --tags k8s-cluster-${CLUSTER_NAME} --location ${AZURE_LOCATION}

echo "create the cluster ${CLUSTER_NAME}"
tanzu cluster create --file azure-cluster.yaml --verbose 9 

