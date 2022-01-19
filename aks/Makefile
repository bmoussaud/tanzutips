
RESOURCE_GROUP=aks-east-coast
CLUSTER_NAME=aks-east-coast-1

login:
	az login
	az account set --subscription cbca10bb-6ddc-45bd-8f18-c17d1dd1003f

create-cluster: 
	az deployment group create  --name AksDeployment1  --resource-group $(RESOURCE_GROUP) --template-file template.json  --parameters '@parameters.json'

get-cluster:
	az aks show --resource-group $(RESOURCE_GROUP) --name $(CLUSTER_NAME)

kubeconfig:
	az aks get-credentials --resource-group $(RESOURCE_GROUP) --name $(CLUSTER_NAME) -f ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml

delete-cluster:
	az aks delete --resource-group $(RESOURCE_GROUP) --name $(CLUSTER_NAME) &&  rm ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml


