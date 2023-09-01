Connect-AzAccount -Subscription [subscriptionID]

Remove-AzVMExtension -Name AzureMonitorLinuxAgent -ResourceGroupName [resourcegroupname] -VMName [hostname] -Force

Set-AzVMExtension -Name AzureMonitorLinuxAgent -ExtensionType AzureMonitorLinuxAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName [resourcegroupname] -VMName [hostname] -Location [region] -TypeHandlerVersion "1.26" -EnableAutomaticUpgrade $true