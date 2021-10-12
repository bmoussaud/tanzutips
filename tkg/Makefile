CLUSTER=bmoussaud-aws-one
PROVIDER=aws

create-cluster:
	CLUSTER_NAME=$(CLUSTER) ./02-new_cluster_$(PROVIDER).sh

get-cluster:
	tanzu cluster get $(CLUSTER)  --show-group-members

all-my-clusters:
	tanzu cluster list

delete-cluster:
	tanzu cluster delete $(CLUSTER) -v 6
	rm ~/.kube/config-files/kubeconfig-$(CLUSTER).yml

kubeconfig:
	echo "load the admin kubeconfig for cluster '$(CLUSTER)'"
	tanzu cluster kubeconfig get $(CLUSTER) --admin --export-file ~/.kube/config-files/kubeconfig-$(CLUSTER).yml
	
kubeconfig-mgmt:
	echo "load the admin mgmt kubeconfig for cluster '$(CLUSTER)'"
	tanzu management-cluster kubeconfig get --admin --export-file ~/.kube/config-files/kubeconfig-$(CLUSTER).yml
	
