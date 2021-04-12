CLUSTER=bmoussaud-aws-one

create-cluster:
	CLUSTER_NAME=$(CLUSTER) ./02-new_cluster_aws.sh

get-cluster:
	tanzu cluster get $(CLUSTER)  --disable-grouping

all-my-clusters:
	tanzu cluster list

delete-cluster:
	tanzu cluster delete $(CLUSTER) -v 6
	#rm ~/.kube/config-files/kubeconfig-$(CLUSTER).yml

kubeconfig:
	./03-kubeconfig.sh
