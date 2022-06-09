
RESOURCE_GROUP=aks-east-coast
CLUSTER_NAME=aks-east-coast-2
LOCATION=france

login:
	az login
	az account set --subscription cbca10bb-6ddc-45bd-8f18-c17d1dd1003f

rg:
	az group create --location $(LOCATION) --resource-group $(RESOURCE_GROUP)

create-cluster: 
	az deployment group create  --name $(CLUSTER_NAME)  --resource-group $(RESOURCE_GROUP) --template-file template.json  --parameters '@parameters.json'

create-cluster-cli: 	
	az aks create --network-plugin="azure" --network-policy="calico" --node-count 3 --enable-cluster-autoscaler --enable-managed-identity --name="$(CLUSTER_NAME)" --resource-group "$(RESOURCE_GROUP)"

get-cluster:
	az aks show --resource-group $(RESOURCE_GROUP) --name $(CLUSTER_NAME)

kubeconfig:
	az aks get-credentials --resource-group $(RESOURCE_GROUP) --name $(CLUSTER_NAME) -f ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml

delete-cluster:
	az aks delete --resource-group $(RESOURCE_GROUP) --name $(CLUSTER_NAME) &&  rm ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml


