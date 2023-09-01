Connect-AzAccount
(Invoke-AzOperationalInsightsQuery -WorkspaceId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -Query `
'
Heartbeat 
| top 10 by TimeGenerated
'`
).Results | Format-Table



Connect-AzAccount
$results = (Invoke-AzOperationalInsightsQuery -WorkspaceId "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx" -Query `
'
Heartbeat 
| limit 20000
'`
)
$date = Get-Date -Format mmddyyyy-ss
$results.Results | Export-Csv C:\users\v-nickmic\Downloads\$date.csv

