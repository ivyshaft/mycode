for ($i = 1; $i -le 10000; $i++ ) {
    Write-Host `r"Progress: $i%" -ForegroundColor Yellow
    Start-Sleep -Milliseconds 10
}
