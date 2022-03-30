# reference https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
CLUSTER_NAME:=aws-eks-back
REGION=eu-west-3

create-eks-cluster:
	echo "create new EKS Cluster $(CLUSTER_NAME) in $(REGION) "
	CLUSTER_NAME=$(CLUSTER_NAME) REGION=$(REGION) envsubst < cluster-template.yaml > $(CLUSTER_NAME)-cluster-config.yaml
	cat $(CLUSTER_NAME)-cluster-config.yaml
	eksctl create cluster -f $(CLUSTER_NAME)-cluster-config.yaml --dry-run
	eksctl create cluster -f $(CLUSTER_NAME)-cluster-config.yaml
	

scale-eks-cluster:
	eksctl scale nodegroup --cluster=$(CLUSTER_NAME) --nodes=3 --name=ng-1

delete-eks-cluster:
	eksctl delete cluster --name $(CLUSTER_NAME)
	rm  ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml

kubeconfig:
	touch ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml
	echo "kubeconfig file is ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml"
	
	#aws eks update-kubeconfig --region $(REGION) --name $(CLUSTER_NAME)  $(CLUSTER_NAME) --alias $(CLUSTER_NAME) --verbose --dry-run > ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml
	eksctl utils write-kubeconfig --cluster=$(CLUSTER_NAME)  --region=$(REGION) --kubeconfig=~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml
	


