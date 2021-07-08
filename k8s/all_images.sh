#https://kubernetes.io/fr/docs/tasks/access-application-cluster/list-all-running-container-images/
kubectl get pods --all-namespaces -o jsonpath="{..image}" |\
tr -s '[[:space:]]' '\n' |\
sort |\
uniq -c


