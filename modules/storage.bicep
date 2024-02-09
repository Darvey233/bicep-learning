@minLength(5)
@maxLength(24)
@description('Only min 5 and max 24 characters')
param storageName string

param location string = 'westus3'

//res-sto
resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: location
  kind: 'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    accessTier: 'Hot'
  }
}
