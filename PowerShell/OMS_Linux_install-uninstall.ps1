# Uninstall OMS Extension Loop
Connect-AzAccount -Subscription "[subscriptionId]"

$names = "xxxxxxxxxxxxxx","xxxxxxxxxxxxxx"

function Uninstall_LinuxOMS {
    $names | ForEach-Object -Process {
        Remove-AzVMExtension -Name OMSExtension -ResourceGroupName AzMonVMs -VMName $PSItem -Force
        }
    }

# Call Function
Uninstall_LinuxOMS

#########################################

# Set function
function Install_LinuxOMS {
    $names | ForEach-Object -Process {
        # Set loop variables
        $release = 1.14
        $rg = [rgname]

        #Process
        Set-AzVMExtension -ResourceGroupName $rg -VMName $PSItem -ExtensionName OmsAgentForLinux -ExtensionType OmsAgentForLinux -Publisher Microsoft.EnterpriseCloud.Monitoring -TypeHandlerVersion $release  -ProtectedSettingString '"workspaceKey":"myWorkspaceKey"}' -SettingString '{"workspaceId":"myWorkspaceId","skipDockerProviderInstall": true}'
        }
    }

# Call Function
Install_LinuxOMS


#########################################
Remove-AzResource -ResourceId "/subscriptions/SUBIDHERE/resourceGroups/RGHERE/providers/Microsoft.Compute/virtualMachines/VMNAMEHERE/extensions/EXTENSIONNAMEHERE" -Force
