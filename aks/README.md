# EKS


## Create a cluster 

```shell
make login
make rg RESOURCE_GROUP=tap LOCATION=francecentral
make create-cluster-cli kubeconfig CLUSTER_NAME=aks-west RESOURCE_GROUP=tap 
```

## Delete a cluster 

```shell
make delete-eks-cluster kubeconfig CLUSTER_NAME=aws-north REGION=eu-west-1
```

