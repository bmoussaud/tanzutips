# https://kubernetes.io/fr/docs/tasks/configure-pod-container/pull-image-private-registry/
DOCKERHUB_USERNAME=$1
DOCKERHUB_PASSWORD=$2
DOCKERHUB_EMAIL=$3

SECRET_NAME=myregistrykey
kubectl delete secret ${SECRET_NAME}
kubectl create secret docker-registry ${SECRET_NAME} --docker-server=https://index.docker.io/v1/ \
  --docker-username=${DOCKERHUB_USERNAME} --docker-password=${DOCKERHUB_PASSWORD} --docker-email=${DOCKERHUB_EMAIL}
kubectl get secret ${SECRET_NAME} --output=yaml
kubectl get secret ${SECRET_NAME} --output="jsonpath={.data.\.dockerconfigjson}" | base64 --decode
# 
