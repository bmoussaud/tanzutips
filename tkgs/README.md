# Procedure

1. Connect to the Supervisor Cluster
```
source .env
./kubectl_vsphere_login.sh
````

2. Create the Workload cluster `bmoussaud/dev01`

````
kubectl apply -f virtualmachineclassbindings.yaml
kubectl apply -f dev01.yaml
````

3. Check the status

`````
kubectl get vm -n bmoussaud
kubectl -n bmoussaud get clusters
kubectl -n bmoussaud describe clusters dev01
`````

4. Connect to the Workload Cluster

```
source .env
./kubectl_vsphere_login_cluster.sh
````

5. Delete the Worload Cluster

````
kubectl delete -f virtualmachineclassbindings.yaml
kubectl delete -f dev01.yaml
````
