
#based on https://github.com/pivotal/kpack/blob/main/docs/tutorial.md
set -x
VERSION=0.2.2
TARGET=macos

curl -o /tmp/release-${VERSION}.yaml -L https://github.com/pivotal/kpack/releases/download/v${VERSION}/release-${VERSION}.yaml 
curl -o /tmp/log-${VERSION}.tgz -L https://github.com/pivotal/kpack/releases/download/v${VERSION}/logs-v${VERSION}-${TARGET}.tgz
tar xvfz /tmp/log-${VERSION}.tgz --directory /usr/local/bin
chmod +x /usr/local/bin/logs


kubectl apply -f  /tmp/release-${VERSION}.yaml 
kubectl get pods --namespace kpack 

rm /tmp/release-${VERSION}.yaml
rm /tmp/log-${VERSION}.tgz



