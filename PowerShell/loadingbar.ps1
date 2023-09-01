for ($i = 1; $i -lt 100; $i++ ) {
    Write-Progress -Activity "Search in Progress" -PercentComplete $i -Status "$i% Complete:"
    Start-Sleep -Milliseconds 20
}

for ($i = 1; $i -le 100; $i++) {
    Write-Progress -Activity "Outer Loop" -status "$i% Complete:" -percentcomplete $i 
    Start-Sleep 0.25
    for ($i = 1; $i -lt 100; $i++) {
        Write-Progress -Activity "Inner Loop" -PercentComplete $i -Status "$i% Complete:"
        Start-Sleep -Milliseconds 20
    }
}
