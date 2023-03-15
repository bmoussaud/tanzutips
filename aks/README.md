# EKS


## Create a cluster     

```shell
make login
make rg RESOURCE_GROUP=tap LOCATION=francecentral
make create-new-cluster CLUSTER_NAME=aks-eu-tap-3 LOCATION=germanywestcentral NODE=4
make create-registry CLUSTER_NAME=aks-eu-tap-3
make attach-registry CLUSTER_NAME=aks-eu-tap-3
```

```
make create-new-cluster CLUSTER_NAME=aks-eu-tap-4 LOCATION=francecentral NODE=4
make create-registry CLUSTER_NAME=aks-eu-tap-4
make attach-registry CLUSTER_NAME=aks-eu-tap-4

make new-instance CLUSTER_NAME=aks-eu-tap-5 LOCATION=francecentral NODE=4

## Delete a cluster and associate resources

```shell
make delete-cluster CLUSTER_NAME=aws-north 
```

## image registry




`````
servicePrincipal=tap-service-principal containerRegistry=bmoussaudregistry ./registry_service_principal.sh                                                                                                                                                       
/subscriptions/cbca10bb-6ddc-45bd-8f18-c17d1dd1003f/resourceGroups/aks-eu-tap-1/providers/Microsoft.ContainerRegistry/registries/bmoussaudregistry
WARNING: This command or command group has been migrated to Microsoft Graph API. Please carefully review all breaking changes introduced during this migration: https://docs.microsoft.com/cli/azure/microsoft-graph-migration
WARNING: Creating 'acrpull' role assignment under scope '/subscriptions/cbca10bb-6ddc-45bd-8f18-c17d1dd1003f/resourceGroups/aks-eu-tap-1/providers/Microsoft.ContainerRegistry/registries/bmoussaudregistry'
WARNING: The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
WARNING: This command or command group has been migrated to Microsoft Graph API. Please carefully review all breaking changes introduced during this migration: https://docs.microsoft.com/cli/azure/microsoft-graph-migration
Service principal ID: xxxxxx-c28a-4de8-bfd2-adf8c0cdc10d
Service principal password: sjh8Q~xxxxxxxxxxxxx.NzpenZMqcg4


containerRegistry=bmoussaudregistry servicePrincipal=tap-service ./registry_service_principal.sh
Service principal ID: da5b002c-c28a-4de8-bfd2-adf8c0cdc10d
Service principal password: WV-8Q~b3qySs8G3AdmV3zbFDfTvosFulx0urNaey
docker login bmoussaudregistry .azurecr.io --username da5b002c-c28a-4de8-bfd2-adf8c0cdc10d --password WV-8Q~b3qySs8G3AdmV3zbFDfTvosFulx0urNaey

`````


