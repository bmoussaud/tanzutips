export NS=${NS:-dev}
kubectl create ns ${NS}
kubectl create secret docker-registry regcred --docker-server=https://docker.io --docker-username=bmoussaud --docker-password=${DOCKER_PASSWORD} --docker-email=benoit@moussaud.org -n ${NS}
#kubectl create deployment whoami --image=containous/whoami -n ${NS}
kubectl apply -f application.yaml -n ${NS}
kubectl expose deployment/whoami-deployment --port=80 --target-port=80 -n ${NS}
kubectl get all -n ${NS}
kubectl -n ${NS} get events
kubectl port-forward  service/whoami-deployment 1080:80 -n ${NS}
