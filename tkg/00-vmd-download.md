# VMD


Repository: https://github.com/laidbackware/vmd


## Queries

```
vmd get products | grep tanzu
vmd get subproducts  -p vmware_tanzu_kubernetes_grid
vmd get versions  -p vmware_tanzu_kubernetes_grid  -s tkg

export VMD_USER=bmoussaud@vmware.com
export VMD_PASS=xxxxx
vmd get files -p vmware_tanzu_kubernetes_grid  -s tkg -v  1.4.0
```

## Download


```
export VMD_USER=bmoussaud@vmware.com
export VMD_PASS=xxxxx
vmd download -p vmware_tanzu_kubernetes_grid  -s tkg -v  1.4.0 -f tanzu-cli-bundle-darwin-amd64.tar --accepteula
```





