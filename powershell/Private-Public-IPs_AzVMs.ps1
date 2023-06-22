# Private and Public IP addresses AzVms

# Connect v-nickmic subscripton
Connect-AzAccount -Subscription "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

function ShowMachineTable {
    $loop = foreach ( $azVM in Get-AzVM ) {

    #$azVm
 
    $networkProfile = $azVm.NetworkProfile.NetworkInterfaces.id.Split("/") | Select-Object -Last 1
 
    $IPConfig = (Get-AzNetworkInterface -Name $networkProfile).IpConfigurations.PrivateIpAddress
    
    $PublicIPname = (Get-AzNetworkInterface -Name $networkProfile).IpConfigurations.PublicIpAddress.id.Split("/") | Select-Object -Last 1
    
    $PublicIP = (Get-AzPublicIpAddress -Name "$PublicIPname").IpAddress
    
    $State = (Get-AzVM -Name $azVM.Name -status).PowerState

    [pscustomobject]@{
 
        "Hostname" = $azVm.OsProfile.ComputerName
 
        "Private Ip" = $IPConfig

        "Public Ip" = $PublicIP

        "State" = $State
 
    }
 
 }
$loop | Format-Table
}

ShowMachineTable