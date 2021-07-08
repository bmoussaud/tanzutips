# reference https://docs.aws.amazon.com/eks/latest/userguide/create-cluster.html
CLUSTER_NAME=aws-eks-back
CLUSTER_ROLE_ARN=xxxx
REGION=eu-west-3
ACCOUNT_ID=xxxxxxx

create-eks-cluster:
	CLUSTER_NAME=$(CLUSTER_NAME) REGION=${AWS_DEFAULT_REGION} envsubst < cluster-template.yaml > $(CLUSTER_NAME)-cluster-config.yaml
	eksctl create cluster -f $(CLUSTER_NAME)-cluster-config.yaml

scale-eks-cluster:
	eksctl scale nodegroup --cluster=$(CLUSTER_NAME) --nodes=3 --name=ng-1

kubeconfig:
	aws eks update-kubeconfig --region $(REGION)  --name $(CLUSTER_NAME) --kubeconfig ~/.kube/config-files/kubeconfig-$(CLUSTER_NAME).yaml


