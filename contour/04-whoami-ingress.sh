kubectl create ns dev
kubectl create deployment whoami --image=containous/whoami -n dev
kubectl expose deployment/whoami --port=80 --target-port=80 -n dev
kubectl apply -f ingress.yaml 
kubectl get ingress -n dev

kubectl get -n dev ingress http-whoami-ingress -o json

AWS_END_POINT=$(kubectl get -n dev ingress http-whoami-ingress -o jsonpath="{.status.loadBalancer.ingress[0].hostname}")

wget --header="Host: whoami.smoke.test" "http://${AWS_END_POINT}/whoami"
