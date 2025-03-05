<#
.DESCRIPTION
A script to toggle sound outputs with a hotkey combo

.SYNOPSIS
The script detects all playback devices and toggles through them on a decided hotkey

.EXAMPLE
Ctrl + Shift + ~
Should toggle your playback device, if you have two or more playback devices enabled.
#>

# Name the PowerShell window
$host.ui.RawUI.WindowTitle = "hotkeys.ps1"
 
# Check for necessary module and install
if (-not (Get-Module -Name "AudioDeviceCmdlets" -ListAvailable)) {
    Install-Module -Name AudioDeviceCmdlets -Force -Verbose  
}
 
# Add swaudio "toggle" function. You must ensure you enable only the audio outputs that you wish to cycle through.
function swaudio {
    $playback_device_current = (Get-AudioDevice -Playback).Index
    $playback_devices = Get-AudioDevice -List |
    Where-Object -Property "Type" -EQ "Playback"
    $playback_devices_count = $playback_devices.Length
    if (
        ($playback_device_current + 1) -gt $playback_devices_count
    ) {
        $playback_device_current = 1
    }
    else {
        $playback_device_current = $playback_device_current + 1
    }
    Set-AudioDevice -Index $playback_device_current
}
 
# Setup keys to listen for
$tilde_key = "0xC0" ## `~
$ctrl_key = "0x11" ## Ctrl
$shift_key = "0x10" ## Shift 
$f9_key = "0x78" ## F9 
$f10_key = "0x79" ## F10 
$f11_key = "0x7A" ## F11 

# Setup dll import to get asynchronous key state definitions in virtualkeycode format
$Signature = @"
[DllImport("user32.dll", CharSet=CharSet.Auto)]
public static extern short GetAsyncKeyState(int vKey);
"@

# Add the async key state definitions as a member
Add-Type -MemberDefinition $Signature -Name Keyboard -Namespace PsOneApi
 
# Infinite do loop to listen for hotkey combo at 25ms frequency
do {   
    if ( 
        [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($ctrl_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($shift_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($tilde_key) -eq -32768)
    ) { 
        # The content of what you want to execute with hotkeys
        swaudio
    }
    
    if ( 
        [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($ctrl_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($shift_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($f9_key) -eq -32768)
    ) { 
        # The content of what you want to execute with hotkeys
        $now = Get-Date -Format "MM-dd-yyyy hh:mm:ss tt"
        $insert = "firstname lastname at " + $now
        $insert |
        Set-Clipboard
    }
        
    if ( 
        [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($ctrl_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($shift_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($f10_key) -eq -32768)
    ) { 
        # The content of what you want to execute with hotkeys
        $insert = "email1@email.com"
        $insert |
        Set-Clipboard
    }
        
    if ( 
        [bool]([PsOneApi.Keyboard]::GetAsyncKeyState($ctrl_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($shift_key) -eq -32768 -and 
            [PsOneApi.Keyboard]::GetAsyncKeyState($f11_key) -eq -32768)
    ) { 
        # The content of what you want to execute with hotkeys
        $insert = "email2@email.com"
        $insert |
        Set-Clipboard
    }
        
    Start-Sleep -Milliseconds 10
    
} while ($true)
