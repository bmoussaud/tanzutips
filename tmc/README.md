# Tanzu Mission Control and AWS

TMC = Tanzu Mission Control

## Inputs

* MANAGEMENT_CLUSTER : the name of the management cluster (eg aws-hosted)
* PROVISIONER: the name of the provisioer (eg bmoussaud-aws)
* CLUSTER: the name of the cluster you want to connect to (eg. bmoussaud-aws-tmc-1)


## Cluster 

### Create a cluster

1. Edit the `cluster.yaml` file and modify it depending your context. 

Example:

````
fullName:
  managementClusterName: $(MANAGEMENT_CLUSTER)
  name: $(CLUSTER) 
  provisionerName:  $(PROVISIONER)
````

2. Run the command `tmc cluster create -f cluster.yaml`

3. Wait for 15 minutes. You can get the state of the cluster by using the following command

````
tmc cluster get -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) $(CLUSTER) 
````

### Connect to your cluster

1. Command Line: 

``` bash 
tmc cluster auth  kubeconfig get -m ${MANAGEMENT_CLUSTER} -p ${PROVISIONER} ${CLUSTER}
```

2. For an easier usage you can redirect its output to a file and use it using `--kubeconfig` flag

```
tmc cluster auth  kubeconfig get -m ${MANAGEMENT_CLUSTER} -p ${PROVISIONER} ${CLUSTER}> .localkubeconfig
kubectl --kubeconfig=.localkubeconfig get namespaces
```

### Delete a Cluster

````
tmc cluster delete -m $(MANAGEMENT_CLUSTER) -p $(PROVISIONER) $(CLUSTER)
````

## Troobleshoot 

### Policies

```
kubectl get validatingwebhookconfigurations gatekeeper-validating-webhook-configuration
``````