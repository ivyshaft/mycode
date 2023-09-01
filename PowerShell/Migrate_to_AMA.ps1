# Uninstall OMS Extension Loop
Connect-AzAccount -Subscription "[subscriptionId]"

$resourcegroup = [resourcegroupname]
$machines = Get-AzVM -ResourceGroupName $resourcegroup

function Migrate_to_AMA {
    $machines | ForEach-Object -Process {
        $resourcegroup = [resourcegroupname]
        Remove-AzVMExtension -Name [extensionname] -ResourceGroupName $resourcegroup -VMName $PSItem -Force
        Set-AzVMExtension -Name [extensionname] -ExtensionType [extensiontype] -Publisher Microsoft.Azure.Monitor -ResourceGroupName $resourcegroup -VMName $PSItem -Location [region] -TypeHandlerVersion "1.16" -EnableAutomaticUpgrade $true
        }
    }

# Call Function
Migrate_to_AMA

# https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-powershell#system-assigned-managed-identity
# https://learn.microsoft.com/en-us/azure/azure-monitor/agents/azure-monitor-agent-manage?tabs=azure-powershell#install-on-azure-arc-enabled-servers


# Get most recent Agent Versions
# Get-AzVMExtensionImage -Location 'eastus2' -PublisherName 'Microsoft.Azure.Monitor' -Type 'AzureMonitorWindowsAgent' | ForEach-Object { $_.Version } | Sort-Object {[version] $_} -Descending | Select-Object -First 5
