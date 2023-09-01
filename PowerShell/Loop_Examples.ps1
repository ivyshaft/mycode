# Set variable to list of VMs
$vms = Get-AzVM

# Version with foreach uses a loop variable name for each pipe object
foreach ($vm in $vms) {
    Write-Host $vm.name
    }

# Version with ForEach-Object uses the PSItem instead of creating a loop variable
$vms | ForEach-Object -Process {
    Write-Host $PSItem.name
}

# Version with ForEach-Object uses the pipe variable $_ instead of creating a loop variable
$vms | ForEach-Object -Process {
    Write-Host $_.name
}

# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_foreach?view=powershell-7.3
# https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/foreach-object?view=powershell-7.3
# https://learn.microsoft.com/en-us/powershell/module/az.compute/get-azvm?view=azps-10.0.0