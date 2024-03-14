#!/bin/bash
# This script requires Azure CLI version 2.25.0 or later. Check version with `az --version`.
# usage: ./new-service-principal.sh keyvault vault-micropets vault-micropets-for-vault-micropets  00482a5a-887f-4fb3-b363-3b7fe8e74483
# Modify for your environment.
# KIND_NAME: The kind of your Resource Azure
# RESOURCE_NAME: The name of your Resource Azure
# SERVICE_PRINCIPAL_NAME: Must be unique within your AD tenant
KIND_NAME=$1
RESOURCE_NAME=$2
SERVICE_PRINCIPAL_NAME=$3
ASSIGNED_ROLE=$4
echo "KIND_NAME:              ${KIND_NAME}"
echo "RESOURCE_NAME:          ${RESOURCE_NAME}"
echo "SERVICE_PRINCIPAL_NAME: ${SERVICE_PRINCIPAL_NAME}"

# Obtain the full registry ID
RESOURCE_NAME_ID=$(az $KIND_NAME show --name $RESOURCE_NAME --query "id" --output tsv)
echo "RESOURCE_NAME_ID:       ${RESOURCE_NAME_ID}"
echo "ASSIGNED_ROLE:          ${ASSIGNED_ROLE}"


# Create the service principal with rights scoped to the registry.
echo "Create a new role for ${SERVICE_PRINCIPAL_NAME}"
PASSWORD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --scopes $RESOURCE_NAME_ID --role $ASSIGNED_ROLE --query "password" --output tsv)
echo "Get the SP APP ID for ${SERVICE_PRINCIPAL_NAME}"
USER_NAME=$(az ad sp list --display-name $SERVICE_PRINCIPAL_NAME --query "[].appId" --output tsv)


# Output the service principal's credentials; use these in your services and
# applications to authenticate to the container registry.
echo "Service principal ID (ClientID): [${USER_NAME}]"
echo "Service principal password (ClientSecret): [${PASSWORD}]"


