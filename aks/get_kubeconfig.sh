set -x
RESOURCE_GROUP=$1
NAME=$2
#az login
az aks get-credentials --resource-group  ${RESOURCE_GROUP}  --name ${NAME} --file /Users/benoitmoussaud/.kube/config-files/kubeconfig-${NAME}.yml

