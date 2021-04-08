echo "install using kubectl "
kubectl apply -f .

kubectl get -n projectcontour service envoy -o wide

NLB_ADRESS=$(kubectl get service envoy --namespace=projectcontour -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "NLB Address is: ${NLB_ADRESS} "

