#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.
#set -x

AKS_CLUSTER=$1
ROLE="contributor"
SERVICE_PRINCIPAL="azure-service-operator"

SERVICE_PRINCIPAL_NAME="${SERVICE_PRINCIPAL}-${ROLE}-${AKS_CLUSTER}"
AZURE_TENANT_ID=$(az account show --output json | jq -r ".tenantId")
AZURE_SUBSCRIPTION_ID=$(az account show --output json | jq -r ".id")

echo "AZURE_TENANT_ID        ${AZURE_TENANT_ID}"
echo "AZURE_SUBSCRIPTION_ID  ${AZURE_SUBSCRIPTION_ID}"
echo "Create a new role for  ${SERVICE_PRINCIPAL_NAME}/${ROLE}"
AZURE_CLIENT_SECRET=$(az ad sp create-for-rbac -n ${SERVICE_PRINCIPAL_NAME} --role ${ROLE} --scopes /subscriptions/${AZURE_SUBSCRIPTION_ID} --query "password" --output tsv)
echo "Get the SP APP ID for  ${SERVICE_PRINCIPAL_NAME}"
AZURE_CLIENT_ID=$(az ad sp list --display-name ${SERVICE_PRINCIPAL_NAME} --query "[].appId" --output tsv)

echo "AZURE_CLIENT_ID: [${AZURE_CLIENT_ID}]"
echo "AZURE_CLIENT_SECRET: [${AZURE_CLIENT_SECRET}]"

REGISTRY_FILE=~/.azure/rbac/${SERVICE_PRINCIPAL_NAME}.config
echo "Generate the password file"
echo "export AZURE_CLIENT_ID=${AZURE_CLIENT_ID}" > ${REGISTRY_FILE}
echo "export AZURE_CLIENT_SECRET=${AZURE_CLIENT_SECRET}" >>  ${REGISTRY_FILE}
echo "export AZURE_TENANT_ID=${AZURE_TENANT_ID}" >> ${REGISTRY_FILE}
echo "export AZURE_SUBSCRIPTION_ID=${AZURE_SUBSCRIPTION_ID}" >> ${REGISTRY_FILE}
echo "Config file location is  ${REGISTRY_FILE}"
