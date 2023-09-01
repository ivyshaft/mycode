# Get Resource Provider Operations for certain keywords
# Set Variables
$ResourceUri = "/SUBSCRIPTIONS/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/RESOURCEGROUPS/RGNAME/PROVIDERS/MICROSOFT.DOCUMENTDB/DATABASEACCOUNTS/RESOURCE"
$operation = "Delete"
$requestResourceProvider = ($ResourceUri.Split("/")[-3]).ToLower()
$ResourceType = ($ResourceUri.Split("/")[-2]).ToLower()
$operation.ToLower()
# Execute Actions
Get-AzProviderOperation ($requestResourceProvider + "/*") `
    | Where-Object -FilterScript {$_.Operation -like "*/$ResourceType/$operation*"} `
    | Format-Table

# Get Resource Provider Operations for certain keywords
# Set Variables
$ResourceUri = "/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/RGNAME/providers/Microsoft.KeyVault/vaults/sample-vault"
$operation = "Delete"
$requestResourceProvider = ($ResourceUri.Split("/")[-3]).ToLower()
$ResourceType = ($ResourceUri.Split("/")[-2]).ToLower()
$operation.ToLower()
# Execute Actions
Get-AzProviderOperation ($requestResourceProvider + "/*") `
    | Where-Object -FilterScript {$_.Operation -like "*/$ResourceType/$operation*"} `
    | Format-Table