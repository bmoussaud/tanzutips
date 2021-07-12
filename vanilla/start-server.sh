sudo apt-get update -y
export K3S_KUBECONFIG_MODE="0644"
curl -sfL https://get.k3s.io | sh -
sudo service k3s status

# Kubeconfig is written to /etc/rancher/k3s/k3s.yaml
mkdir ~/.kube/
sudo cp  /etc/rancher/k3s/k3s.yaml ~/.kube/config
sudo chmod 666 ~/.kube/config

echo "K3S_TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)"


