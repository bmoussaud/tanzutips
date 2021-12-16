az deployment group create  --name AksDeployment1  --resource-group aks-east-coast --template-file template.json  --parameters '@parameters.json'
