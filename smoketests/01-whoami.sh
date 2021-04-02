kubectl create ns dev
kubectl create deployment whoami --image=containous/whoami -n dev
kubectl expose deployment/whoami --port=80 --target-port=80 -n dev
kubectl get all -n dev
kubectl -n dev get events
kubectl port-forward  service/whoami 1080:80 -n dev
