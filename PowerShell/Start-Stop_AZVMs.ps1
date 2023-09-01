# Start or Stop all VMs in a subscription
# Function Definitions
#-----------------------
function AzAuth {
    #Connect subscripton
    Connect-AzAccount -Subscription "00000000-0000-0000-0000-000000000000"
}

function StartVms {
    $vms = Get-AzVM
    $vms | ForEach-Object -Begin {
        Clear-Host
        $i = 0
        $vmcount = ($vms | Measure-Object).Count
        $Completed = 0
    } -Process {
        Write-Host `r"$Completed% Completed"
            Start-AzVm -Name $_.Name -ResourceGroupName $_.ResourceGroupName 
            Write-Host "
    -----------------------------------------------------------------
            "$_.Name"started successfully 
    -----------------------------------------------------------------
            " -ForegroundColor DarkYellow
        $i = $i + 1
        $Completed = ($i/$vmcount) * 100
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
