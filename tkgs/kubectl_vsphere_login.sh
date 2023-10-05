# usage VSPHERE_ADDRESS=172.17.12.128 VSPHERE_PASSWORD=xxxxx ./kubectl_vsphere_login.sh
set -x
export VSPHERE_USERNAME=${VSPHERE_USERNAME:-administrator@vsphere.local }
export VSPHERE_ADDRESS=${VSPHERE_ADDRESS:-10.213.163.64}
export KUBECTL_VSPHERE_PASSWORD=${VSPHERE_PASSWORD}
echo "K8S Connect on ${VSPHERE_ADDRESS} using ${VSPHERE_USERNAME}"

kubectl vsphere login --server=${VSPHERE_ADDRESS} --vsphere-username ${VSPHERE_USERNAME} --insecure-skip-tls-verify
kubectl config use-context ${VSPHERE_ADDRESS}
