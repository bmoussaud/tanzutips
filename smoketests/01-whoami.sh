kubectl create ns dev
kubectl create deployment whoami --image=harbor.mytanzu.xyz/library/whoami@sha256:e6d0a6d995c167bd339fa8b9bb2f585acd9a6e505a6b3fb6afb5fcbd52bbefb8 -n dev
kubectl expose deployment/whoami --port=80 --target-port=80 -n dev
kubectl get all -n dev
kubectl -n dev get events
kubectl port-forward  service/whoami 1080:80 -n dev
