# Get a table of Resource Provider operations for the specified RP
Get-AzProviderOperation Microsoft.KeyVault/vaults/* | Format-Table OperationName, Operation, IsDataAction, Description -Wrap

# Setting a property as the view you want
$apple = (Get-AzProviderOperation Microsoft.KeyVault/vaults/*).Operation
$apple

#or

$apple = Get-AzProviderOperation Microsoft.KeyVault/vaults/* | Format-Table -Property Operation
$apple