#set -x
# https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.3/vmware-tanzu-kubernetes-grid-13/GUID-extensions-index.html#install-carvel
KUBE_CONFIG=kubeconfig-aws-one.yml
kubectl --kubeconfig=.localkube/${KUBE_CONFIG} apply -f tkg-extensions-v1.3.0+vmware.1/extensions/tmc-extension-manager.yaml
kubectl --kubeconfig=.localkube/${KUBE_CONFIG} apply -f tkg-extensions-v1.3.0+vmware.1/cert-manager

echo "Check extension-manager....."
kubectl --kubeconfig=.localkube/${KUBE_CONFIG} get pod -A | grep extension-manager
echo "Check kapp-controller..."
kubectl --kubeconfig=.localkube/${KUBE_CONFIG} get pod -A  | grep kapp-controller

echo "Check cert-manager..."
kubectl --kubeconfig=.localkube/${KUBE_CONFIG} get pod -A  | grep cert-manager

echo "Check all is RUNNING..."
kubectl --kubeconfig=.localkube/${KUBE_CONFIG} get pod -A 

