
CLUSTER_NAME=aks-east-coast-2
LOCATION=francecentral
REGISTRY_NAME=bmoussaudregistry

login:
	az login
	az account set --subscription cbca10bb-6ddc-45bd-8f18-c17d1dd1003f

rg:
	az group create --location $(LOCATION) --resource-group $(CLUSTER_NAME)

create-new-cluster: rg create-cluster kubeconfig kubeconfig-admin grant-permission 

create-cluster: 
	CLUSTER_NAME=$(CLUSTER_NAME) ./new_tap_cluster.sh


create-cluster-cli: 	
	az aks create --network-plugin="azure" --network-policy="calico" --node-count 3 --enable-cluster-autoscaler --enable-managed-identity --name="$(CLUSTER_NAME)" --resource-group "$(CLUSTER_NAME)"

get-cluster:
	az aks show --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)

kubeconfig:
	az aks get-credentials --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) -f ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yml

kubeconfig-admin:
	az aks get-credentials --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) -f ~/.kube/config-files/kubeconfig-admin-$(CLUSTER_NAME).yml

grant-permission: kubeconfig-admin
	kubectl create clusterrolebinding tap-psp-rolebinding --group=system:authenticated --clusterrole=psp:privileged --kubeconfig ~/.kube/config-files/kubeconfig-admin-$(CLUSTER_NAME).yml 

delete-cluster: delete-cluster-cli clean-kubeconfig

delete-cluster-cli: 
	az aks delete --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) 

clean-kubeconfig:
	@-rm ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yml
	@-rm ~/.kube/config-files/kubeconfig-admin-$(CLUSTER_NAME).yml 

registry:
	az acr create --resource-group $(CLUSTER_NAME)  --name $(REGISTRY_NAME) --sku Standard

reglogin:
	az acr login --name $(REGISTRY_NAME)
	
	

