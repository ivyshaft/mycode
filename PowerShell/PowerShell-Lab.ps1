
$myobject = 
[PSCustomObject]@{"Key1" = "2"; "Key2" = "2"},
[PSCustomObject]@{"Key1" = "3"; "Key2" = "3"}
$myobject | Sort-Object -Property Key1 -Descending

$myobject = @([PSCustomObject]@{"Key1" = "1"; "Key2" = "1"},
    [PSCustomObject]@{"Key1" = "2"; "Key2" = "2"})
$myobject | Sort-Object -Property Key1 -Descending


$Counter = 40
do {
@("/", "|", "\", "-") `
| ForEach-Object -Process {
    Write-Host "`r$_" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 250
    $Counter = $Counter - 1
    }
}until ($Counter -le 0)

$Counter = 0
do {
@("/", "|", "\", "-") `
| ForEach-Object -Process {
    Write-Host "`r$_" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 250
    $Counter = $Counter + 1
    }
}until ($Counter -gt 20)