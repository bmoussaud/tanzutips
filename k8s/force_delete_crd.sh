#https://stackoverflow.com/questions/52009124/not-able-to-completely-remove-kubernetes-customresource
CRD=$1

kubectl patch crd/${CRD} -p '{"metadata":{"finalizers":[]}}' --type=merge
kubectl delete crd ${CRD}

