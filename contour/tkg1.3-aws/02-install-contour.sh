#set -x
# https://docs.vmware.com/en/VMware-Tanzu-Kubernetes-Grid/1.3/vmware-tanzu-kubernetes-grid-13/GUID-extensions-ingress-contour.html#prepare-the-tanzu-kubernetes-cluster-for-contour-deployment-1
EXTENSION_DIR="/Users/bmoussaud/Downloads/tkg-extensions-v1.3.0+vmware.1/extensions"
TARGET="aws"
pushd ${EXTENSION_DIR}

pwd

kubectl apply -f ingress/contour/namespace-role.yaml
cp ingress/contour/${TARGET}/contour-data-values.yaml.example  ingress/contour/${TARGET}/contour-data-values.yaml
cat ingress/contour/${TARGET}/contour-data-values.yaml
kubectl create secret generic contour-data-values --from-file=values.yaml=ingress/contour/${TARGET}/contour-data-values.yaml -n tanzu-system-ingress
kubectl apply -f ingress/contour/contour-extension.yaml

popd

