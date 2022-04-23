# reference https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
CLUSTER_NAME:=aws-eks-back
REGION=eu-west-3
NODE_TYPE=m5.xlarge
NODE_NUMBER=1

create-eks-cluster:
	echo "create new EKS Cluster $(CLUSTER_NAME) in $(REGION) "
	CLUSTER_NAME=$(CLUSTER_NAME) REGION=$(REGION) NODE_TYPE=$(NODE_TYPE) NODE_NUMBER=$(NODE_NUMBER) envsubst < cluster-template.yaml > $(CLUSTER_NAME)-cluster-config.yaml
	cat $(CLUSTER_NAME)-cluster-config.yaml
	eksctl create cluster -f $(CLUSTER_NAME)-cluster-config.yaml --dry-run
	eksctl create cluster -f $(CLUSTER_NAME)-cluster-config.yaml
	
scale-eks-cluster:
	eksctl scale nodegroup --cluster=$(CLUSTER_NAME) --nodes=3 --name=ng-1

delete-eks-cluster:
	eksctl delete cluster --name $(CLUSTER_NAME) --region=$(REGION) 	
	rm ~/.kube/eksctl/clusters/$(CLUSTER_NAME)

kubeconfig:
	eksctl utils write-kubeconfig --cluster=$(CLUSTER_NAME)  --region=$(REGION) --auto-kubeconfig
	


