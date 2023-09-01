$tableParams = @'
{
   "properties": {
       "schema": {
              "name": "CustomTable_CL",
              "columns": [
       {
                               "name": "TimeGenerated",
                               "type": "DateTime"
                       }, 
                      {
                               "name": "RawData",
                               "type": "String"
                      }
             ]
       }
   }
}
'@

Invoke-AzRestMethod -Path "/subscriptions/00000000-0000-0000-0000-000000000000/resourcegroups/monitoringrg/providers/microsoft.operationalinsights/workspaces/demo-workspace/tables/CustomTable_CL?api-version=2021-12-01-preview" -Method PUT -payload $tableParams