
# whoami 

Deploy whoami container and expose it using kubectl forward on port 1080

```
$curl http://localhost:1080/
Hostname: whoami-84f56668f5-zznl2
IP: 127.0.0.1
IP: ::1
IP: 192.168.202.234
IP: fe80::4830:4bff:fec7:9809
RemoteAddr: 127.0.0.1:34204
GET / HTTP/1.1
Host: localhost:1080
User-Agent: curl/7.64.1
Accept: */*
```

## container has runAsNonRoot and image will run as root

Hi, we have now enabled a restrictive pod security policy (https://kubernetes.io/docs/concepts/policy/pod-security-policy/) by default on Kubernetes clusters provisioned through Tanzu Mission Control. This policy will prevent the usage of privileged options in your containers like running the container as root, using privileged mode, hostPath volume mounts, hostNetwork and privileged Linux capabilities. This is done to keep your Kubernetes clusters secure by default.
With that said, some of you might want to use some of these privileged options in your pods. In order to make it easier to use them, we also have a privileged pod security policy. To enable this for a specific pod, you can give the service account it uses the permission to use the privileged pod security policy using the following command:
```
kubectl create rolebinding privileged-role-binding \
    --clusterrole=vmware-system-tmc-psp-privileged \
    --user=system:serviceaccount:<namespace>:<service-account>
```
To enable it for the entire cluster, you can use the following command:
```
kubectl create clusterrolebinding privileged-cluster-role-binding \
    --clusterrole=vmware-system-tmc-psp-privileged \
    --group=system:authenticated
```
