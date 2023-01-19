#
# https://docs.vmware.com/en/VMware-Tanzu-Mission-Control/services/tanzumc-using/GUID-44FF9964-2333-462E-B3EB-40D7A51B3F54.html#GUID-44FF9964-2333-462E-B3EB-40D7A51B3F54
# https://confluence.eng.vmware.com/pages/viewpage.action?spaceKey=CNA&title=v1alpha1+CLI+for+Data+protection
#
AZURE_BACKUP_SUBSCRIPTION_NAME=bmoussaud
AZURE_BACKUP_SUBSCRIPTION_ID=$(az account list --query="[?name=='$AZURE_BACKUP_SUBSCRIPTION_NAME'].id | [0]" -o tsv)
az account set -s $AZURE_BACKUP_SUBSCRIPTION_ID

echo "--- Create an Azure storage account and a blob container "
echo "---- Create a resource group for the backup storage account."
AZURE_BACKUP_RESOURCE_GROUP=Velero_Backups
echo "----  AZURE_BACKUP_RESOURCE_GROUP ${AZURE_BACKUP_RESOURCE_GROUP}"
az group delete -n $AZURE_BACKUP_RESOURCE_GROUP --yes
az group create -n $AZURE_BACKUP_RESOURCE_GROUP --location WestUS

echo "---- Create the storage account in the resource group."
AZURE_STORAGE_ACCOUNT_ID="bck$(uuidgen | cut -d '-' -f5 | tr '[A-Z]' '[a-z]')"
echo "----  AZURE_STORAGE_ACCOUNT_ID ${AZURE_STORAGE_ACCOUNT_ID}"
az storage account create --name $AZURE_STORAGE_ACCOUNT_ID --resource-group $AZURE_BACKUP_RESOURCE_GROUP --sku Standard_GRS --encryption-services blob --https-only true --kind BlobStorage --access-tier Hot


echo "---- Create the blob container."
BLOB_CONTAINER="bmoussaudblobcontainer"
echo "----  BLOB_CONTAINER ${BLOB_CONTAINER}"
az storage container create -n $BLOB_CONTAINER --public-access off --account-name $AZURE_STORAGE_ACCOUNT_ID

echo "--- Create a service principal"
AZURE_TENANT_ID=`az account list --query '[?isDefault].tenantId' -o tsv`
echo "----  AZURE_TENANT_ID ${AZURE_TENANT_ID}"
AZURE_ROLE=Contributor
AZURE_ROLE_NAME="${AZURE_BACKUP_SUBSCRIPTION_NAME}_${AZURE_ROLE}_for_velero"
AZURE_CLIENT_SECRET=`az ad sp create-for-rbac --name "${AZURE_ROLE_NAME}" --role $AZURE_ROLE --query 'password' -o tsv --scopes /subscriptions/$AZURE_BACKUP_SUBSCRIPTION_ID`
echo "----  AZURE_CLIENT_SECRET ${AZURE_CLIENT_SECRET}"
AZURE_CLIENT_ID=`az ad sp list --display-name "${AZURE_ROLE_NAME}" --query '[0].appId' -o tsv`
echo "----  AZURE_CLIENT_ID ${AZURE_CLIENT_ID}"


echo "--- Create a TMC credentials "
TMC_CREDS_NAME="${AZURE_BACKUP_SUBSCRIPTION_NAME}-blobstorage"
echo "----  TMC_CREDS_NAME ${TMC_CREDS_NAME}"
set -x 
tmc  account credentials delete  ${TMC_CREDS_NAME}
tmc  account credentials create --azure-cloud-name AzurePublicCloud --client-id ${AZURE_CLIENT_ID} --client-secret ${AZURE_CLIENT_SECRET} --resource-group ${AZURE_BACKUP_RESOURCE_GROUP} --name ${TMC_CREDS_NAME} --subscription-id ${AZURE_BACKUP_SUBSCRIPTION_ID} --tenant-id ${AZURE_TENANT_ID} --provider AZURE_AD --capability DATA_PROTECTION


#TMC_BCK_TARGET="${AZURE_BACKUP_SUBSCRIPTION_NAME}-target"
#tmc dataprotection provider backuplocation create --credential-name ${TMC_BCK_TARGET} --target-provider AZURE --storage-account ${AZURE_STORAGE_ACCOUNT_ID} 
