#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.

# Modify for your environment.
# ACR_NAME: The name of your Azure Container Registry
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant
ACR_NAME=$1
SERVICE_PRINCIPAL_NAME=$2
echo "ACR_NAME ${ACR_NAME}"
echo "SERVICE_PRINCIPAL_NAME ${SERVICE_PRINCIPAL_NAME}"

# Obtain the full registry ID
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query "id" --output tsv)
echo "ACR_REGISTRY_ID ${ACR_REGISTRY_ID}"

# Create the service principal with rights scoped to the registry.
# Default permissions are for docker pull access. Modify the '--role'
# argument value as desired:
# acrpull:     pull only
# acrpush:     push and pull
# owner:       push, pull, and assign roles
echo "Create a new role for ${SERVICE_PRINCIPAL_NAME}"
PASSWORD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $ACR_REGISTRY_ID --role acrpush --query "password" --output tsv)
echo "Get the SP APP ID for ${SERVICE_PRINCIPAL_NAME}"
USER_NAME=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv)


# Output the service principal's credentials; use these in your services and
# applications to authenticate to the container registry.
echo "Service principal ID: [${USER_NAME}]"
echo "Service principal password: [${PASSWORD}]"
echo "docker login..."

REGISTRY_FILE=~/.kube/acr/.${ACR_NAME}.config
echo "Generate the password file"
echo "export INSTALL_REGISTRY_PASSWORD=${PASSWORD}" > ${REGISTRY_FILE}
echo "export INSTALL_REGISTRY_USERNAME=${USER_NAME}" >>  ${REGISTRY_FILE}
echo "export INSTALL_REGISTRY_HOSTNAME=${ACR_NAME}.azurecr.io" >>  ${REGISTRY_FILE}
echo "function test_registry_${ACR_NAME} {" >>  ${REGISTRY_FILE}
echo "    az acr login --name ${ACR_NAME}" >>  ${REGISTRY_FILE}
echo "    sleep 5" >>  ${REGISTRY_FILE}
echo "    docker login ${ACR_NAME}.azurecr.io -u ${USER_NAME} -p ${PASSWORD}" >>  ${REGISTRY_FILE}
echo "}" >>  ${REGISTRY_FILE}
echo "REGISTRY Config file is ${REGISTRY_FILE}"
source ${REGISTRY_FILE}
