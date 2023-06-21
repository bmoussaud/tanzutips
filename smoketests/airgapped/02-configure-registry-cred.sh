source registry.config.sh
NS=default
kubectl create secret docker-registry regcred --docker-server=https://${INSTALL_REGISTRY_HOSTNAME} --docker-username=${INSTALL_REGISTRY_USERNAME} --docker-password=${INSTALL_REGISTRY_PASSWORD}  -n ${NS}