# Script to get and remove DCR Associations with a single machine

# Set Execution Policy
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser

# Install and update needed module
Install-Module -Name Az -Repository PSGallery -Force
Update-Module -Name Az -Force

# Connect and Authenticate to needed subscripton
Connect-AzAccount -Subscription [subscriptionid]

# Get VM details
$vm = Get-AzVM -ResourceGroupName [rgname] -Name [vmname]

# Get DCR Associations - Fill in the DCR name you wish to delete the association at "*[DCRNAME]*"
$association = Get-AzDataCollectionRuleAssociation -TargetResourceId $vm.Id | Where-Object -Property Name -like "*[DCRNAME]*"

Remove-AzDataCollectionRuleAssociation -TargetResourceId $vm.Id -AssociationName $association.Name


# https://learn.microsoft.com/en-us/powershell/module/az.accounts/connect-azaccount?view=azps-9.7.1
# https://learn.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-9.7.1
# https://learn.microsoft.com/en-us/powershell/module/az.monitor/get-azdatacollectionruleassociation?view=azps-9.7.1
# https://learn.microsoft.com/en-us/powershell/module/az.monitor/remove-azdatacollectionruleassociation?view=azps-9.7.1 