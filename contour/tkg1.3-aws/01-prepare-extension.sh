#set -x
# https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.3/vmware-tanzu-kubernetes-grid-13/GUID-extensions-index.html#install-carvel
EXTENSION_DIR="/Users/bmoussaud/Downloads/tkg-extensions-v1.3.0+vmware.1"
pushd ${EXTENSION_DIR}
pwd
kubectl  apply -f extensions/tmc-extension-manager.yaml
kubectl  apply -f extensions/kapp-controller.yaml
kubectl  apply -f cert-manager

echo "Check extension-manager....."
kubectl  get pod -A | grep extension-manager
echo "Check kapp-controller..."
kubectl  get pod -A  | grep kapp-controller

echo "Check cert-manager..."
kubectl  get pod -A  | grep cert-manager

echo "Check all is RUNNING..."
kubectl  get pod -A

popd
