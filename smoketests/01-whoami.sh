export NS=${NS:-dev}
kubectl create ns ${NS}
kubectl create deployment whoami --image=containous/whoami -n ${NS}
kubectl expose deployment/whoami --port=80 --target-port=80 -n ${NS}
kubectl get all -n ${NS}
kubectl -n ${NS} get events
kubectl port-forward  service/whoami 1080:80 -n ${NS}
