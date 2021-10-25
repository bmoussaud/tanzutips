# usage VSPHERE_CLUSTER=bmoussaud VSPHERE_ADDRESS=172.17.12.128 VSPHERE_PASSWORD=xxxxx ./kubectl_vsphere_login_cluster.sh
export VSPHERE_USERNAME=${VSPHERE_USERNAME:-administrator@vsphere.local }
export VSPHERE_ADDRESS=${VSPHERE_ADDRESS:-10.213.163.64}
export KUBECTL_VSPHERE_PASSWORD=${VSPHERE_PASSWORD}
export VSPHERE_CLUSTER=${VSPHERE_CLUSTER:-dev01}
export VSPHERE_NAMESPACE=${VSPHERE_NAMESPACE:-bmoussaud}
echo "K8S Connect on Cluster ${VSPHERE_NAMESPACE}/${VSPHERE_CLUSTER}"

kubectl vsphere login --server=${VSPHERE_ADDRESS} --vsphere-username ${VSPHERE_USERNAME} --insecure-skip-tls-verify --tanzu-kubernetes-cluster-name ${VSPHERE_CLUSTER}  --tanzu-kubernetes-cluster-namespace ${VSPHERE_NAMESPACE}
kubectl config use-context ${VSPHERE_CLUSTER}
