# Ref: http://theblasfrompas.blogspot.com/2020/05/creating-my-first-tanzu-kubernetes-grid.html
# Ref: https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file

# tested TKG 14/AZURE
# dependencies : bash, tanzu , envsubst, aws cli

export AZURE_LOCATION=francecentral
export CLUSTER_NAME=${CLUSTER_NAME:-bmoussaud-az-paris-mgt-cluster}
export CLUSTER_RG=tkg-paris

export LOCAL_SSH_PUBLIC_KEY=${LOCAL_SSH_PUBLIC_KEY:-/root/.ssh/1674826159_6842616.pub}
export RESSOURCE_GROUP=${RESSOURCE_GROUP:-tkg21}

if [[ -z "${AZURE_SUBSCRIPTION_ID}" ]]; then
    echo "please provide AZURE_SUBSCRIPTION_ID"
    exit 1
fi

echo "--- Create a service principal"
AZURE_TENANT_ID=`az account list --query '[?isDefault].tenantId' -o tsv`
echo "----  AZURE_TENANT_ID ${AZURE_TENANT_ID}"
AZURE_ROLE=Owner
AZURE_ROLE_NAME="BMOUSSAUD_TKG_${AZURE_ROLE}_for_${RESSOURCE_GROUP}"
export AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "${AZURE_ROLE_NAME}" --role $AZURE_ROLE --query 'password' -o tsv --scopes /subscriptions/${AZURE_SUBSCRIPTION_ID}/resourceGroups/${RESSOURCE_GROUP}
echo "----  AZURE_CLIENT_SECRET ${AZURE_CLIENT_SECRET}"
export AZURE_CLIENT_ID=`az ad sp list --display-name "${AZURE_ROLE_NAME}" --query '[0].appId' -o tsv`
echo "----  AZURE_CLIENT_ID ${AZURE_CLIENT_ID}"

if [[ -z "${AZURE_CLIENT_ID}" ]]; then
    echo "please provide AZURE_CLIENT_ID"
    exit 1
fi

if [[ -z "${AZURE_CLIENT_SECRET}" ]]; then
    echo "please provide AZURE_CLIENT_SECRET"
    exit 1
fi

#export AZURE_SSH_PUBLIC_KEY_B64=$(cat ~/.ssh/id_rsa.pub | awk {'print $1,$2'} | base64)
export AZURE_SSH_PUBLIC_KEY_B64=$(cat ${LOCAL_SSH_PUBLIC_KEY} | awk {'print $1,$2'} | base64)

envsubst < ./azure-management-cluster-template.yaml | grep -v '""' | grep -v "#" | sort > azure-management-cluster.yaml


cat azure-management-cluster.yaml

echo "create the management cluster"
tanzu management-cluster create --file azure-management-cluster.yaml -v 6 

