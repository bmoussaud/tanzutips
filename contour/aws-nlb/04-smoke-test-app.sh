kubectl apply -f 04-kuard.yaml
kubectl get po,svc,ing -l app=kuard -n smoketest
NLB_ADRESS=$(kubectl get service envoy --namespace=projectcontour -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
echo "NLB Address is: ${NLB_ADRESS} "

set -x
wget "http://${NLB_ADRESS}"

wget --header="Host: kuard.smoke.test" "http://${NLB_ADRESS}/"
