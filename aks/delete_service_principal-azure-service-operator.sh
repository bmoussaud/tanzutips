#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.
set -x

AKS_CLUSTER=$1
ROLE="contributor"
SERVICE_PRINCIPAL="azure-service-operator"
SERVICE_PRINCIPAL_NAME="${SERVICE_PRINCIPAL}-${ROLE}-${AKS_CLUSTER}"

SP_ID=$(az ad sp list --display-name ${SERVICE_PRINCIPAL_NAME} --query "[].id" --output tsv)

echo "delete ${SERVICE_PRINCIPAL_NAME} => ${SP_ID}"
az ad sp delete --id ${SP_ID}
REGISTRY_FILE=~/.azure/rbac/${SERVICE_PRINCIPAL_NAME}.config
echo "delete ${REGISTRY_FILE}"
rm ${REGISTRY_FILE}