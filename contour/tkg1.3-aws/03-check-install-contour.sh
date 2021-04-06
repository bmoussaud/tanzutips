#set -x
# https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.3/vmware-tanzu-kubernetes-grid-13/GUID-extensions-ingress-contour.html#prepare-the-tanzu-kubernetes-cluster-for-contour-deployment-1
EXTENSION_DIR="/Users/bmoussaud/Downloads/tkg-extensions-v1.3.0+vmware.1"
TARGET="aws"
kubectl get extension contour -n tanzu-system-ingress
kubectl get app contour -n tanzu-system-ingress
kubectl get app contour -n tanzu-system-ingress -o yaml
kubectl get pods -A
kubectl  get svc envoy -n tanzu-system-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'


