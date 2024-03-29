CLUSTER=aws-usa-1
MANAGEMENT_CLUSTER=bmoussaud-mgt-cluster
PROVISIONER=default
ADD_KUBECONFIG_FILES=~/.kube/config-files


create-cluster:
	tmc cluster create -f cluster.yaml

create-cluster-cli:
	tmc cluster create --account-name  $(PROVISIONER)-credential --cluster-group bmoussaud --instance-type m5.large --name $(CLUSTER) --region eu-west-3 --ssh-key-name tmc-keypair  --version 1.19.4-1-amazon2 --worker-node-count 1  --description "$(CLUSTER) created by bmoussaud" --management-cluster-name $(MANAGEMENT_CLUSTER) --provisioner-name $(PROVISIONER) --availability-zone eu-west-3a

create-cluster-ha-cli:
	tmc cluster create --template aws-ha --account-name  $(PROVISIONER)-credential --cluster-group bmoussaud --instance-type m5.large --name $(CLUSTER) --region eu-west-3 --ssh-key-name tmc-keypair  --version 1.19.4-1-amazon2 --worker-node-count 3  --description "$(CLUSTER) created by bmoussaud" --management-cluster-name $(MANAGEMENT_CLUSTER) --provisioner-name $(PROVISIONER) --cluster-availability-zones  eu-west-3a,eu-west-3b,eu-west-3c --nodepool-availability-zone eu-west-3a 

check-cluster-phase:
	tmc cluster get -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) $(CLUSTER) | grep phase

get-cluster:
	tmc cluster get -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) $(CLUSTER) 

all-my-clusters:
	tmc cluster list -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) 

delete-cluster:
	tmc cluster delete -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) $(CLUSTER)
	rm ~/.kube/config-files/kubeconfig-$(CLUSTER).yml

kubeconfig:
	tmc cluster auth  kubeconfig get -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) $(CLUSTER)> ~/.kube/config-files/kubeconfig-$(CLUSTER).yml
