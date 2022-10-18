#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.
# source https://www.thorsten-hans.com/external-dns-azure-kubernetes-service-azure-dns/
# source https://github.com/kubernetes-sigs/external-dns/blob/master/docs/tutorials/azure.md
#set -x

AKS_CLUSTER=$1
SERVICE_PRINCIPAL="sp"
DNS_NAME="mytanzu.xyz"

AZ_SP_NAME=sp-external-dns-${AKS_CLUSTER}

echo "Create a new Service Principal ${AZ_SP_NAME}"
SP_CFG=$(az ad sp create-for-rbac -n $AZ_SP_NAME -o json)

echo "Extract essential information...."

SP_CLIENT_ID=$(echo $SP_CFG | jq -e -r 'select(.appId != null) | .appId')
SP_CLIENT_SECRET=$(echo $SP_CFG | jq -e -r 'select(.password != null) | .password')
SP_SUBSCRIPTIONID=$(az account show --query id -o tsv)
SP_TENANTID=$(echo $SP_CFG | jq -e -r 'select(.tenant != null) | .tenant')

echo "SP_CLIENT_ID: ${SP_CLIENT_ID}"
echo "SP_CLIENT_SECRET: ${SP_CLIENT_SECRET}"
echo "SP_SUBSCRIPTIONID: ${SP_SUBSCRIPTIONID}"
echo "SP_TENANTID: ${SP_TENANTID}"

DNS_ID=$(az network dns zone show --resource-group  ${DNS_NAME}  --name ${DNS_NAME} --query id -o tsv) 
echo "DNS_ID ${DNS_ID}"

echo "Create DNS Zone Contributor role assignment "
az role assignment create --assignee ${SP_CLIENT_ID} --role "DNS Zone Contributor" --scope ${DNS_ID}

echo "Create Reader role assignment "
az role assignment create --assignee  ${SP_CLIENT_ID}  --role "Reader" --scope ${DNS_ID}


echo "Creating a configuration file for the service principal"
cat <<-EOF > /tmp/azure.json
{
  "tenantId": "$(az account show --query tenantId -o tsv)",
  "subscriptionId": "$(az account show --query id -o tsv)",
  "resourceGroup": "${DNS_NAME}",
  "aadClientId": "${SP_CLIENT_ID}",
  "aadClientSecret": "${SP_CLIENT_SECRET}"
}
EOF

cat /tmp/azure.json
kubectl create secret generic azure-config-file --namespace "default" --from-file /tmp/azure.json


# Add Helm repository
helm repo add bitnami https://charts.bitnami.com/bitnami

# Update repositories
helm repo update

# Create Kubernetes namespace for External-DNS
kubectl create namespace externaldns

# Create tailored External-DNS deployment

helm install external-dns bitnami/external-dns \
    --wait \
    --namespace externaldns \
    --set txtOwnerId=$AKS_CLUSTER \
    --set provider=azure \
    --set azure.resourceGroup=$AZ_DNS_GROUP \
    --set txtOwnerId=$AKS_CLUSTER \
    --set azure.tenantId=$AZ_TENANT_ID \
    --set azure.subscriptionId=$AZ_SUBSCRIPTION_ID \
    --set azure.aadClientId=$SP_CLIENT_ID \
    --set azure.aadClientSecret="$SP_CLIENT_SECRET" \
    --set azure.cloud=AzurePublicCloud \
    --set policy=sync \
    --set domainFilters={$DOMAIN_NAME}
