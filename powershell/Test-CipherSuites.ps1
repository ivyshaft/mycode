# Test matching suites to an endpoint
$filepath = ($home + "\" + (HOSTNAME.EXE)  + "_CipherSuites" + "_" + (Get-Date -Format "MMddyy_hhmm") + ".txt")
$endpoint = "google.com"
# Invoke-WebRequest #[Download and install NMAP]
Set-Location "C:\Program Files (x86)\Nmap"
$get_ciphers = .\nmap.exe -sV --script ssl-enum-ciphers -p 443 $endpoint
$selected_ciphers = $get_ciphers `
    | Select-String "TLS_+[A-Za-z0-9_]*"
$matching_suites = $selected_ciphers.Matches.Value
$message = "
Available Cipher Suites for $endpoint
" 
$message | Out-File $filepath -Append
$matching_suites | Out-File $filepath -Append
$message
$matching_suites

Set-Location $home
$local_suites = Get-TLSCipherSuite
$local_suites `
    | Add-Member -NotePropertyMembers @{Enabled="YES"}
$enabled_local_suites = $local_suites `
    | Where-Object {$_.Name -in $matching_suites} `
    | Format-Table Name, Enabled
$enabled_local_suites
$enabled_local_suites `
    | Out-File $filepath -Append `
    | explorer.exe $filepath
