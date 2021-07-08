export K3S_TOKEN="benoitK10ba7b6f17d0015bf45044e0602e068dc31658ecdabe942f50a26390edd4f935eb::server:712915e056949934faecc502b3e88f75"
export K3S_URL="https://52.47.196.27:6443benoi"

#sudo k3s agent --server https://${MASTER}:6443 --token ${NODE_TOKEN}
curl -sfL https://get.k3s.io | sh -
