$Counter = 15
do {
@("/", "|", "\", "-") `
| ForEach-Object -Process {
    Write-Host "`r$_" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 250
    $Counter = $Counter - 1
    }
}until ($Counter -le 0)
Write-Host "Hello World" -ForegroundColor Green
Pause
$name = Read-Host "Type your name"
Write-Host "Hello there, $name. Hope you are well today. Program shutting down now." -ForegroundColor Red
Start-Sleep -Seconds 5
$Counter = 15
do {
@("/", "|", "\", "-") `
| ForEach-Object -Process {
    Write-Host "`r$_" -NoNewline -ForegroundColor Green
    Start-Sleep -Milliseconds 250
    $Counter = $Counter - 1
    }
}until ($Counter -le 0)