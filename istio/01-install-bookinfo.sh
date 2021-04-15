#ref https://istio.io/latest/docs/examples/bookinfo/
kubectl apply -n dev -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get services -n dev
kubectl get pods -n dev


kubectl exec -n dev "$(kubectl get pod -n dev -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/bookinfo/networking/bookinfo-gateway.yaml -n dev

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

kubectl get gateway -n dev
echo $GATEWAY_URL
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"
