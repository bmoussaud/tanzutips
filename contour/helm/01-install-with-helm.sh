helm repo add bitnami https://charts.bitnami.com/bitnami
helm install my-release bitnami/contour

kubectl get svc my-release-contour-envoy --namespace default
kubectl describe svc my-release-contour-envoy --namespace default | grep Ingress | awk '{print $3}'
