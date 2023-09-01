$VMRG = "AzMonVMS"
$vmName = "WinServerB"
$vm = Get-AzVM -ResourceGroupName $VMRG -Name $vmName
$location = $vm.location
Set-AzVMExtension -ExtensionName "Microsoft.Azure.Monitoring.DependencyAgent" -ResourceGroupName $VMRG -VMName $vmName -Publisher "Microsoft.Azure.Monitoring.DependencyAgent" -ExtensionType "DependencyAgentWindows" -TypeHandlerVersion 9.5 -Location $location
