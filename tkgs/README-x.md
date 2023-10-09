# Procedure

## Connect to the Supervisor Cluster

```
source .env
./kubectl_vsphere_login.sh
```

## Create the Workload cluster 

````
kubectl apply -f virtualmachineclassbindings.yaml
kubectl apply -f dev01.yaml
````

## Check the status

`````
kubectl get vm -n bmoussaud
kubectl -n bmoussaud get clusters
kubectl -n bmoussaud describe clusters dev01
`````

## Connect to the Workload Cluster

````
source .env
./kubectl_vsphere_login_cluster.sh
````

````
kubectl create clusterrolebinding default-tkg-admin-privileged-binding \
--clusterrole=psp:vmware-system-privileged --group=system:authenticated
````

## Upgrading a cluster

Edit Tanzu Kubernetes Cluster object:

```bash
./kubectl_vsphere_login.sh
kubectl -n bmoussaud edit tkc dev01
```

Set `fullVersion` to `null`, then update the `version` attribute accordingly.

## Delete the Workload Cluster

````
./kubectl_vsphere_login.sh
kubectl delete -f virtualmachineclassbindings.yaml
kubectl delete -f dev01.yaml
````
