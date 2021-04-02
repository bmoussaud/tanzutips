# Ref: http://theblasfrompas.blogspot.com/2020/05/creating-my-first-tanzu-kubernetes-grid.html
# Ref: https://stackoverflow.com/questions/415677/how-to-replace-placeholders-in-a-text-file

# tested TKG 13/AWS
# dependencies : bash, tanzu , envsubst, 
export CLUSTER_NAME="aws-one"
echo "load the admin kubeconfig for cluster ${CLUSTER_NAME}"
tanzu cluster kubeconfig get ${CLUSTER_NAME} --admin
kubectl config use-context ${CLUSTER_NAME}-admin@${CLUSTER_NAME}

