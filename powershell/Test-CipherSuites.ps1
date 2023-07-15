# Test matching suites to an endpoint (Requires NMAP installed)
$homepath = (Get-Location).Path
$filepath = ($homepath + "\" + (HOSTNAME.EXE)  + "_CipherSuites" + "_" + (Get-Date -Format "MMddyy_hhmm") + ".txt")
$endpoint = $args[0]
# Invoke-WebRequest #[Download and install NMAP]
Set-Location "C:\Program Files (x86)\Nmap"
$get_ciphers = .\nmap.exe -sV --script ssl-enum-ciphers -p 443 $endpoint
$selected_ciphers = $get_ciphers `
    | Select-String "TLS_+[A-Za-z0-9_]*"
$matching_suites = $selected_ciphers.Matches
$message = "Available Cipher Suites for $endpoint" 
$matching_suites_formatted = $matching_suites `
    | Format-Table @{Label = "$message"; Expression = "Value"}
$matching_suites_formatted
$matching_suites_formatted `
    | Out-File $filepath -Append
$match_Values = $matching_suites.Value

Set-Location $homepath
$local_suites = Get-TLSCipherSuite
$enabled_local_suites = $local_suites `
    | Where-Object {$_.Name -in $match_Values} `
    | Format-Table @{Label = "Found these locally enabled matches"; Expression = "Name"}
$enabled_local_suites
$enabled_local_suites `
    | Out-File $filepath -Append `
    | explorer.exe $filepath
