#export K3S_TOKEN="benoitK10ba7b6f17d0015bf45044e0a26390edd4f935eb::server:712915e056949934faecc502b3e88f75"
#export K3S_URL="https://52.47.196.27:6443benoi"

#sudo k3s agent --server https://${MASTER}:6443 --token ${NODE_TOKEN}
#K3S_TOKEN=K108feaeb80b5c13e81dc29389da21b16e3965facada894284d8e29d69260768037::server:31e20d09f4165684c3b87010db6b3d20 K3S_URL="https://35.180.227.62:6443" ./start-node.sh
curl -sfL https://get.k3s.io | sh -
