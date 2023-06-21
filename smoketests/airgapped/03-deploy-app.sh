NS=default
kubectl apply -f application.yaml -n ${NS}
kubectl expose deployment/whoami-deployment --port=80 --target-port=80 -n ${NS}
kubectl get all -n ${NS}
kubectl -n ${NS} get events
kubectl port-forward  service/whoami-deployment 1080:80 -n ${NS}