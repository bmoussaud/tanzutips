# EKS


## Create a cluster 

```shell
make login
make rg RESOURCE_GROUP=tap LOCATION=francecentral
make create-new-cluster CLUSTER_NAME=aks-west LOCATION=francecentral
```

## Delete a cluster 

```shell
make delete--cluster CLUSTER_NAME=aws-north 
```

