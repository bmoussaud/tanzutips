
echo "Login in TMC"
echo "Administration -> Management Clusters ->  Register Management Cluster : Tanzu Kubernetes Grid"

echo "Set the context on the management cluster"
tanzu  management-cluster kubeconfig get --admin
echo "Set the context on the management cluster"
kubectl config use-context bmoussaud-mgt-cluster-admin@bmoussaud-mgt-cluster
echo "Register the mgt cluster in TMC"
kubectl apply -f https://tanzuemea.tmc.cloud.vmware.com/installer?id=1e0df655ed2bde4ad60ab98d383af9f48b73ce7beeb8fb7c7bf4b353f39696f6&source=registration

