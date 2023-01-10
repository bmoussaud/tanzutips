#!/bin/bash

#set -x
VAULT_NAME=$1 

SERVICE_PRINCIPAL_NAME="${VAULT_NAME} Reader"
ROLE_NAME="Key Vault Secrets User"
ROLE_NAME_ADMIN="Key Vault Administrator"
YAML_FILE=~/.azure/rbac/${VAULT_NAME}.yaml

echo "VAULT_NAME             ${VAULT_NAME}"
echo "SERVICE_PRINCIPAL_NAME ${SERVICE_PRINCIPAL_NAME}"
echo "ROLE_NAME              ${ROLE_NAME}"

# Obtain the full vault ID
VAULT_ID=$(az keyvault show --name ${VAULT_NAME} --query "id" --output tsv)
echo "VAULT_ID               ${VAULT_ID}"

echo "Create a new admin role for bmoussaud@vmware.com on ${VAULT_NAME}"
az role assignment create --role "${ROLE_NAME_ADMIN}" --assignee "bmoussaud@vmware.com" --scope ${VAULT_ID}

echo "Create a new role for ${SERVICE_PRINCIPAL_NAME} on ${VAULT_NAME}"
PASSWORD=$(az ad sp create-for-rbac --name "${SERVICE_PRINCIPAL_NAME}" --scopes ${VAULT_ID} --role "${ROLE_NAME}" --query "password" --output tsv)
echo "Get the SP APP ID for ${SERVICE_PRINCIPAL_NAME}"
USER_NAME=$(az ad sp list --display-name "${SERVICE_PRINCIPAL_NAME}" --query "[].appId" --output tsv)

TENANT_ID=$(az account show --query tenantId | tr -d \")

# Output the service principal's credentials; use these in your services and
# applications to authenticate to the vault.
echo "Service principal ID:         [${USER_NAME}]"
echo "Service principal password:   [${PASSWORD}]"
echo "Config file location is ${YAML_FILE}"
echo "kubectl apply -f ${YAML_FILE}"
touch ${YAML_FILE}
cat <<EOF > ${YAML_FILE}
apiVersion: v1
kind: Secret
metadata:
  name: azure-secret-sp   
  namespace: external-secrets
stringData:    
  ClientID: ${USER_NAME}
  ClientSecret: ${PASSWORD}     
--- 
apiVersion: external-secrets.io/v1beta1
kind: ClusterSecretStore
metadata:
  name: cluster-azure-backend
spec:
  provider:
    azurekv:
      tenantId: ${TENANT_ID}
      vaultUrl: https://${VAULT_NAME}.vault.azure.net
      authSecretRef:
        clientId:
          name: azure-secret-sp
          namespace: external-secrets
          key: ClientID
        clientSecret:
          name: azure-secret-sp
          namespace: external-secrets
          key: ClientSecret
---
EOF


