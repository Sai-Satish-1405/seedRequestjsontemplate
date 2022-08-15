param storageAccounts_rgsrstorageaccount_name string = 'rgsrstorageaccount'

resource storageAccounts_rgsrstorageaccount_name_resource 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccounts_rgsrstorageaccount_name
  location: 'eastus'
  tags: {
    rgsreaus: 'ResourceGroupSeedRequestEAstUS'
    type: 'storageaccountWebappStatic'
  }
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_rgsrstorageaccount_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-09-01' = {
  parent: storageAccounts_rgsrstorageaccount_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_rgsrstorageaccount_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-09-01' = {
  parent: storageAccounts_rgsrstorageaccount_name_resource
  name: 'default'
  sku: {
    name: 'Standard_RAGRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_rgsrstorageaccount_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-09-01' = {
  parent: storageAccounts_rgsrstorageaccount_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_rgsrstorageaccount_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-09-01' = {
  parent: storageAccounts_rgsrstorageaccount_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_rgsrstorageaccount_name_default_web 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  parent: storageAccounts_rgsrstorageaccount_name_default
  name: '$web'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [

    storageAccounts_rgsrstorageaccount_name_resource
  ]
}