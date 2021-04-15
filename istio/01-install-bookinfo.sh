#ref https://istio.io/latest/docs/examples/bookinfo/
NAMESPACE=istio-dev
kubectl create ns ${NAMESPACE}

kubectl apply -n ${NAMESPACE} -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl get services -n ${NAMESPACE}
kubectl get pods -n ${NAMESPACE}


kubectl exec -n ${NAMESPACE} "$(kubectl get pod -n ${NAMESPACE} -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"

kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.9/samples/bookinfo/networking/bookinfo-gateway.yaml -n ${NAMESPACE}

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].hostname}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export GATEWAY_URL=$INGRESS_HOST:$INGRESS_PORT

kubectl get gateway -n ${NAMESPACE}
echo $GATEWAY_URL
curl -s "http://${GATEWAY_URL}/productpage" | grep -o "<title>.*</title>"
