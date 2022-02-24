# https://craignewtondev.medium.com/how-to-fix-kubernetes-namespace-deleting-stuck-in-terminating-state-5ed75792647e
NS=$1
kubectl get namespace ${NS} -o json > /tmp/${NS}.json
cat /tmp/${NS}.json | grep -v '"kubernetes' > /tmp/${NS}ed.json
kubectl replace --raw "/api/v1/namespaces/${NS}/finalize" -f /tmp/${NS}ed.json
kubectl delete namespaces ${NS}

