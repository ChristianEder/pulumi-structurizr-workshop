az group create --name "resourceGroupName" --location "westeurope"
az group deployment create --resource-group "resourceGroupName" --template-file "template.json" --parameters sku=Free skuCode=F1