# Import and Install modules
Import-Module Az.Accounts
Import-Module Az.Storage
Install-Module -Name Az.Accounts -RequiredVersion 2.11.2
Install-Module -Name AZ.Storage

# Declare Variables
$resourceGroup = "resourcegroup"
$storageAccount = "storageaccount"
$container = "container"
$destination = "c:\blobs"
$file = "c:\blobs\ExportedLogs.csv"

# Create destination directory if it doesn't exist
if (-not (Test-Path -Path $destination -PathType Container)) {
    New-Item -Path $destination -ItemType Directory
}

# Authenticate to Azure and set subscription context
Connect-AzAccount
Set-AzContext -Subscription "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"

# Get storage account with container we want to download blobs from
$storageAccount = Get-AzStorageAccount -Name $storageAccount -ResourceGroupName $resourceGroup

# Get all BlockBlobs from container, filtered results
$key = (Get-AzStorageAccountKey -ResourceGroupName $resourceGroup -Name $storageAccount)[0].Value
$myctx = New-AzStorageContext -StorageAccountName $storageAccount -StorageAccountKey $key
$blockBlobs = Get-AzStorageBlob -Container $container -Context $myctx | Where-Object {
    ($_.Name -like "*/y=2022/m=11*") -or ($_.Name -like "*/y=2022/m=12*")
} | Select-Object -Property "Name"

# Loop to clean names and append rows to CSV (DO NOT OPEN THE CSV DURING THIS PROCESS)

$blockBlobs | ForEach-Object -Process {
# Clean blob names
$cleaned = ($blockBlobs -split "Name=")[1]
$blob = ($cleaned -split "}")[0]

# Download Content
Get-AzStorageBlobContent -Container $container -Blob $blob -Context $myctx -Destination $destination

# Convert JSON to CSV
$pathToJsonFile = ($destination + "\" + $blob)
((Get-Content -Path $pathToJsonFile) | ConvertFrom-Json) | Export-CSV $file -NoTypeInformation -Append

    # Remove JSON files from disk
    Remove-Item ($destination + "\" + "WorkspaceResourceId=") -Recurse
}