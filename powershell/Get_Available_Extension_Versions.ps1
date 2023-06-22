Get-AzVMExtensionImage -Location 'eastus' -PublisherName 'Microsoft.Azure.Monitor' -Type 'AzureMonitorWindowsAgent' | ForEach-Object { $_.Version } | Sort-Object {[version] $_} -Descending | Select-Object -First 5


Get-AzVMExtensionImage -Location 'eastus' -PublisherName 'Microsoft.Azure.Monitor' -Type 'AzureMonitorLinuxAgent' | ForEach-Object { $_.Version } | Sort-Object {[version] $_} -Descending | Select-Object -First 5