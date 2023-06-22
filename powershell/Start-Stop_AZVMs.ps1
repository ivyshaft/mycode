# Start or Stop all VMs in a subscription
# Function Definitions
#-----------------------
function AzAuth {
    #Connect subscripton
    Connect-AzAccount -Subscription "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
}

function StartVms {
    $vms = Get-AzVM
    $vms | ForEach-Object {
            Start-AzVm -Name $($_.name) -ResourceGroupName $_.ResourceGroupName
            Write-Host "
    -----------------------------------------------------------------
            "$_.Name"started successfully 
    -----------------------------------------------------------------
            " -ForegroundColor DarkYellow
        }
}

function StopVms {
    $vms = Get-AzVM
    $vms | ForEach-Object {
            Stop-AzVm -Name $($_.name) -ResourceGroupName $_.ResourceGroupName -Force
            Write-Host "
    -----------------------------------------------------------------
            "$_.Name"stopped successfully
    -----------------------------------------------------------------
            " -ForegroundColor Red
        }
}

# Start Vms
#-----------------------
AzAuth
StartVms


#Stop VMs
#-----------------------
AzAuth
StopVms
