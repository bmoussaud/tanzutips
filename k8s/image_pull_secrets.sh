# https://kubernetes.io/fr/docs/tasks/configure-pod-container/pull-image-private-registry/
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#add-imagepullsecrets-to-a-service-account
DOCKERHUB_USERNAME=$1
DOCKERHUB_PASSWORD=$2
DOCKERHUB_EMAIL=$3

SECRET_NAME=myregistrykey
NAMESPACE=inspector
kubectl delete secret ${SECRET_NAME} -n ${NAMESPACE}
kubectl create secret docker-registry ${SECRET_NAME} --docker-server=https://index.docker.io/v1/ \
  --docker-username=${DOCKERHUB_USERNAME} --docker-password=${DOCKERHUB_PASSWORD} --docker-email=${DOCKERHUB_EMAIL} -n ${NAMESPACE}
kubectl get secret ${SECRET_NAME} --output=yaml -n ${NAMESPACE}
kubectl get secret ${SECRET_NAME} --output="jsonpath={.data.\.dockerconfigjson}" -n ${NAMESPACE} | base64 --decode 
# 
