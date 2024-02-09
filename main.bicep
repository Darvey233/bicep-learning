param location string = 'westus3'
param storageName = 'spacetestapp'

param namePrefix string = 'paulon'

targetScope = 'resourceGroup'

//how to consume modules
module storage 'modules/storage.bicep' = {
  name: storageName
  params: {
    storageName: storageName
    location: location
  }
}

module appPlanDeploy 'modules/servicePlan.bicep' = {
  name: 'appPlanDeploy'
  params: {
    namePrefix: namePrefix
    location: location
  }
}

module deployWebsite 'modules/webApp.bicep' = {
  name: '${namePrefix}-deploy-website'
  params: {
    appPlanId: appPlanDeploy.outputs.planId
    location: location
  }
}
output siteUrl string = deployWebsite.outputs.siteUrl

// param location string = resourceGroup().location
// param storageName string = 'space${uniqueString(resourceGroup().id)}'

// resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
//   name: name
//   location: location
//   kind: 'StorageV2'
//   sku: {
//     name: 'Premium_LRS' //different sizes for our resource
//   }
//   properties: {
//     accessTier: 'Hot'
//   }
// }

// resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
//   name: 'xyz${storageName}'
//   location: location
//   sku: {
//     name: 'F1'
//   }
// }

// resource webApplication 'Microsoft.Web/sites@2023-01-01' = {
//   name: 'zed${storageName}'
//   location: location
//   properties: {
//     serverFarmId: appServicePlan.id
//     httpsOnly: true
//   }
// }

//az group create -g MyFirstDemo -l westus3

//az deployment group create -g MyFirstDemo -f main.bicep

//az deployment sub create --name <deployment-name> --location
//<location> --template-file <path-to-bicep>
//targetScope ='managamentGroup'

//az group delete --name WebAppGroup
