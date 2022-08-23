set -x

export CLUSTER_NAME=${CLUSTER_NAME:-tap-demo}
#az account list-locations
export LOCATION=${LOCATION:-germanywestcentral}
export NODES=${NODES:-3}

az login
az group create --location ${LOCATION} --name ${CLUSTER_NAME}

# Add pod security policies support preview (required for learningcenter)
az extension add --name aks-preview
az extension update --name aks-preview
az feature register --name PodSecurityPolicyPreview --namespace Microsoft.ContainerService
# Wait until the status is "Registered" (30 minuts)
az feature list -o table --query "[?contains(name, 'Microsoft.ContainerService/PodSecurityPolicyPreview')].{Name:name,State:properties.state}"
az provider register --namespace Microsoft.ContainerService

# az aks create --resource-group ${CLUSTER_NAME} --name ${CLUSTER_NAME} --node-count 4 --enable-addons monitoring --node-vm-size Standard_DS3_v2 --node-osdisk-size 500 --enable-pod-security-policy

az aks create --resource-group ${CLUSTER_NAME} --name ${CLUSTER_NAME} --node-count ${NODES} --enable-addons monitoring --node-vm-size standard_b4ms  --enable-pod-security-policy


#az aks get-credentials --resource-group ${CLUSTER_NAME} --name ${CLUSTER_NAME} --file ~/.kube/config-files/kubeconfig-${CLUSTER_NAME}.yml
#az aks get-credentials --admin --resource-group ${CLUSTER_NAME} --name ${CLUSTER_NAME} --file ~/.kube/config-files/kubeconfig-admin-${CLUSTER_NAME}.yml

#KUBECONFIG=~/.kube/config-files/kubeconfig-admin-${CLUSTER_NAME}.yml kubectl create clusterrolebinding tap-psp-rolebinding --group=system:authenticated --clusterrole=psp:privileged
