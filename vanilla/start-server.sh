sudo apt-get update -y
curl -sfL https://get.k3s.io | sh -
# Kubeconfig is written to /etc/rancher/k3s/k3s.yaml
mkdir ~/.kube/
sudo cp  /etc/rancher/k3s/k3s.yaml ~/.kube/config

