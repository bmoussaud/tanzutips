sudo apt-get update -y
curl -sfL https://get.k3s.io | sh -

sudo k3s server &
# Kubeconfig is written to /etc/rancher/k3s/k3s.yaml
mkdir ~/.kube/
sudo cp  /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chmod 666 ~/.kube/config

