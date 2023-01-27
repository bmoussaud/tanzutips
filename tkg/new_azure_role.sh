echo "--- Create a service principal"
AZURE_TENANT_ID=`az account list --query '[?isDefault].tenantId' -o tsv`
echo "----  AZURE_TENANT_ID ${AZURE_TENANT_ID}"
AZURE_ROLE=Owner
AZURE_ROLE_NAME="BMOUSSAUD_TKG_${AZURE_ROLE}_for_${RESSOURCE_GROUP}"
AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "${AZURE_ROLE_NAME}" --role $AZURE_ROLE --query 'password' -o tsv --scopes /subscriptions/$AZURE_SUBSCRIPTION_ID/resourceGroups/${RESSOURCE_GROUP}
echo "----  AZURE_CLIENT_SECRET ${AZURE_CLIENT_SECRET}"
AZURE_CLIENT_ID=`az ad sp list --display-name "${AZURE_ROLE_NAME}" --query '[0].appId' -o tsv`
echo "----  AZURE_CLIENT_ID ${AZURE_CLIENT_ID}"