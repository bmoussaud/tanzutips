
CLUSTER_NAME=aks-east-coast-2
LOCATION=francecentral
REGISTRY_NAME=$(shell echo $(subst -,,$(CLUSTER_NAME)-Registry) | tr '[:upper:]' '[:lower:]') 
REGISTRY_SP_NAME=$(CLUSTER_NAME)-acr 
NODES=3

login:
	az login
	az account set --subscription cbca10bb-6ddc-45bd-8f18-c17d1dd1003f

rg:
	az group create --location $(LOCATION) --resource-group $(CLUSTER_NAME)

create-new-cluster: rg create-cluster kubeconfig-admin grant-permission 

create-cluster: 
	CLUSTER_NAME=$(CLUSTER_NAME) NODES=$(NODES) ./new_tap_cluster.sh

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
	
stop-cluster: 
	az aks stop --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) 

start-cluster: 
	az aks start --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) 

clean-kubeconfig:
	@-rm ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yml
	@-rm ~/.kube/config-files/kubeconfig-admin-$(CLUSTER_NAME).yml 

create-registry:	
	az acr create --resource-group $(CLUSTER_NAME) --name $(REGISTRY_NAME) --sku Basic
	./create-service-principal.sh $(REGISTRY_NAME) $(REGISTRY_SP_NAME)
	az aks update --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)   --attach-acr $(REGISTRY_NAME)

attach-registry:
	az aks update --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)   --attach-acr $(REGISTRY_NAME)

detach-registry:
	az aks update --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)   --detach-acr  $(REGISTRY_NAME)

registry-username:	
	$(eval ACR_USER_NAME=$(shell az ad sp list --display-name $(REGISTRY_SP_NAME) --query "[].appId" --output tsv))
	@echo ACR_USER_NAME is $(ACR_USER_NAME)

delete-registry: detach-registry
	docker logout $(strip $(REGISTRY_NAME)).azurecr.io
	az acr delete --resource-group $(CLUSTER_NAME) --name $(REGISTRY_NAME) 
	$(eval APP_ID=$(shell az ad sp list --display-name $(REGISTRY_SP_NAME) --query "[].appId" --output tsv))
	@echo APP_ID IS $(APP_ID)
	az ad sp delete --id $(APP_ID)
	@-rm ~/.kube/acr/.$(strip $(REGISTRY_NAME))registry.config


deploy-external-dns:
	


	

	

	
	

