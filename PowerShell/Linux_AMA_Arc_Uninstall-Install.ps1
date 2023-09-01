# Uninstall Agent Extension
Remove-AzConnectedMachineExtension -Name AzureMonitorLinuxAgent -ResourceGroupName [resourcegroupname] -MachineName [hostname]

# Install Agent Extension
Set-AzConnectedMachineExtension -Name AzureMonitorLinuxAgent -ExtensionType AzureMonitorLinuxAgent -Publisher Microsoft.Azure.Monitor -ResourceGroupName [resourcegroupname] -MachineName [hostname] -Location [region] -TypeHandlerVersion "1.27" -EnableAutomaticUpgrade $true