# Test matching suites to an endpoint
# Run by calling the file from a PowerShell terminal and an argument with and endpoint like this:
    # .\Test-CipherSuites.ps1 "linkedin.com"
    # A file will be produced in the current directory with the results of matching suites on the host

# Set Variables and ask for argument
$homepath = (Get-Location).Path
$filepath = ($homepath + "\" + (HOSTNAME.EXE)  + "_CipherSuites" + "_" + (Get-Date -Format "MMddyy_hhmm") + ".txt")
$endpoint = $args[0]

# Test if NMAP is installed and if it's not, then install it
if (-not (Test-Path -Path "C:\Program Files (x86)\Nmap" -PathType Container)) {
    Invoke-WebRequest "https://nmap.org/dist/nmap-7.94-setup.exe" -OutFile ($homepath + "\nmap-7.94-setup.exe")
    .\nmap-7.94-setup.exe /S
}

# Add message for Table heading
$message = "Available Cipher Suites for $endpoint"

# Change to NMAP directory and execute Cipher Scan against indicated endpoint in arguments
Set-Location "C:\Program Files (x86)\Nmap"
$get_ciphers = .\nmap.exe -sV --script ssl-enum-ciphers -p 443 $endpoint

# Regex filter to select only the ciphers from NMAP returns
$selected_ciphers = $get_ciphers `
    | Select-String "TLS_+[A-Za-z0-9_]*"
$matching_suites = $selected_ciphers.Matches

# Format the results with descriptive tables
$matching_suites_formatted = $matching_suites `
    | Format-Table @{Label = "$message"; Expression = "Value"} `
    | Sort-Object -Property "$message"

# Display results to console
$matching_suites_formatted

# Export reulting table to OutFile
$matching_suites_formatted `
    | Out-File $filepath -Append

#Prep variable with string values to match against
$match_Values = $matching_suites.Value

# Change to original path
Set-Location $homepath

# Add message for another Table heading
$secondmessage = "Found these locally enabled matches"

# Get the list of locally enabled Cipher Suites for the host machine
$local_suites = Get-TLSCipherSuite

# Look for matches from this list of Cipher Suites from $match_Values, rename table with descriptive heading
$enabled_local_suites = $local_suites `
    | Where-Object {$_.Name -in $match_Values} `
    | Format-Table @{Label = "$secondmessage"; Expression = "Name"}
    | Sort-Object -Property "$secondmessage"

# Display matching Cipher Suites from host and $endpoint
$enabled_local_suites

# Export results to OutFile, Open Explorer
$enabled_local_suites `
    | Out-File $filepath -Append `
    | explorer.exe $filepath
