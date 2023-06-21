
# whoami (Air Gapped )

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

# How-to

Edit airgapped/registry.config.sh to set your registry settingss
* INSTALL_REGISTRY_HOSTNAME
* INSTALL_REGISTRY_USERNAME
* INSTALL_REGISTRY_PASSWORD

```
$airgapped/00-pull_image.sh              (pull the image from docker.io else use the .tar already 
available in the directory)
```

```
$airgapped/01-push_image.sh               (need imgpck and the tar file)
```

```
$airgapped/02-configure-registry-cred.sh  (need to have KUBECONFIG configured)
```

```
$airgapped/03-deploy-app.sh                (need to have KUBECONFIG configured)
```
