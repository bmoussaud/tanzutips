# https://docs.vmware.com/en/VMware-Tanzu-Application-Platform/1.5/tap/install-azure-resources.html
CLUSTER_NAME=aks-east-coast-2
LOCATION=francecentral
REGISTRY_NAME=$(shell echo $(subst -,,$(CLUSTER_NAME)-Registry) | tr '[:upper:]' '[:lower:]') 
REGISTRY_SP_NAME=$(CLUSTER_NAME)-acr 
KUBERNETES_VERSION=1.25.6

login:
	az login
	az account set --subscription cbca10bb-6ddc-45bd-8f18-c17d1dd1003f

rg:
	az group create --location $(LOCATION) --resource-group $(CLUSTER_NAME)

new-instance: rg create-cluster create-registry kubeconfig-admin

delete-instance: 
	az aks delete -g $(CLUSTER_NAME) -n $(CLUSTER_NAME)

# --uptime-sla Message: Base managed cluster SKU name is invalid. 'Basic' has been replaced by 'Base' since v2023-02-01.
create-cluster: 	
	az aks create -g $(CLUSTER_NAME) -n $(CLUSTER_NAME) --enable-managed-identity --node-count 4 --enable-addons monitoring --enable-msi-auth-for-monitoring --generate-ssh-keys --node-vm-size Standard_D8as_v4 --kubernetes-version $(KUBERNETES_VERSION) --enable-oidc-issuer --enable-workload-identity

get-cluster:
	az aks show --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)

kubeconfig:
	az aks get-credentials --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) -f ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yml

kubeconfig-admin:
	az aks get-credentials --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME) -f ~/.kube/config-files/kubeconfig-admin-$(CLUSTER_NAME).yml

grant-permission: kubeconfig-admin
	kubectl create clusterrolebinding tap-psp-rolebinding --group=system:authenticated --clusterrole=psp:privileged --kubeconfig ~/.kube/config-files/kubeconfig-admin-$(CLUSTER_NAME).yml 

delete-cluster: delete-instance clean-kubeconfig

delete-rg-cli: 
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

attach-registry:
	az aks update --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)   --attach-acr $(REGISTRY_NAME)

detach-registry:
	az aks update --resource-group $(CLUSTER_NAME) --name $(CLUSTER_NAME)   --detach-acr  $(REGISTRY_NAME)

registry-username:	
	$(eval ACR_USER_NAME=$(shell az ad sp list --display-name $(REGISTRY_SP_NAME) --query "[].appId" --output tsv))
	@echo ACR_USER_NAME is $(ACR_USER_NAME)

delete-registry: 
	docker logout $(strip $(REGISTRY_NAME)).azurecr.io
	az acr delete --resource-group $(CLUSTER_NAME) --name $(REGISTRY_NAME) 
	$(eval APP_ID=$(shell az ad sp list --display-name $(REGISTRY_SP_NAME) --query "[].appId" --output tsv))
	@echo APP_ID IS $(APP_ID)
	az ad sp delete --id $(APP_ID)
	@-rm ~/.kube/acr/.$(strip $(REGISTRY_NAME)).config

add-node-pool:
	az aks nodepool add --resource-group $(CLUSTER_NAME) --cluster-name $(CLUSTER_NAME) --name poolone --node-count 3 --node-vm-size standard_b4ms --mode System --no-wait 

RESOURCE_GROUP="mytanzu.xyz"	
VAULT_NAME="vault-micropets"
create-keyvault:		
	az keyvault create --name $(VAULT_NAME) --resource-group $(RESOURCE_GROUP) --enable-rbac-authorization
	./create-service-principal-keyvault.sh $(VAULT_NAME)

delete-keyvault:
	az keyvault delete --name $(VAULT_NAME) --resource-group $(RESOURCE_GROUP)
	rm ~/.azure/rbac/$(VAULT_NAME).yaml


	


	

	

	
	

