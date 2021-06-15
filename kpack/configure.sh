#based on https://github.com/pivotal/kpack/blob/main/docs/tutorial.md
NAMESPACE=default

if [[ -z "${REGISTRY_USERNAME}" ]]; then
    echo "please provide REGISTRY_USERNAME"
    exit 1
fi

if [[ -z "${REGISTRY_PASSWORD}" ]]; then
    echo "please provide REGISTRY_PASSWORD"
    exit 1
fi

REGISTRY_URL=${REGISTRY_URL:-https://index.docker.io/v1/}

echo "create a secret to access to ${REGISTRY_URL} for username ${REGISTRY_USERNAME}"

kubectl create secret docker-registry myharbor-registry-credentials \
    --docker-username=${REGISTRY_USERNAME} \
    --docker-password=${REGISTRY_PASSWORD} \
    --docker-server=${REGISTRY_URL} \
    --namespace ${NAMESPACE}


cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: ServiceAccount
metadata:
  name: myharbor-service-account
  namespace: ${NAMESPACE}
secrets:
- name: myharbor-registry-credentials
imagePullSecrets:
- name: myharbor-registry-credentials
EOF

kubectl get sa myharbor-service-account -n ${NAMESPACE}

kubectl delete -f ./yaml -n ${NAMESPACE}
kubectl apply  -f ./yaml -n ${NAMESPACE}


