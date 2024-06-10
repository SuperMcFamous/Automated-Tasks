# Powershell script to set an automatic shutdown time
# Made by SuperMcFamous


# Prompt user to input the shutdown time
$shutdownTime = Read-Host "Enter the shutdown time (e.g., 10:00 PM)"

# Convert the shutdown time to a DateTime object
$shutdownDateTime = Get-Date -Date $shutdownTime

# Calculate the time until shutdown
$timeUntilShutdown = New-TimeSpan -Start (Get-Date) -End $shutdownDateTime

# Validate if the shutdown time is in the future
if ($timeUntilShutdown.TotalSeconds -gt 0) {
    # Schedule the shutdown task
    $shutdownScript = @"
    Add-Type -AssemblyName System.Windows.Forms
    \$shutdownTime = Get-Date '$shutdownTime'
    \$shutdownDelay = New-TimeSpan -Start (Get-Date) -End \$shutdownTime
    Start-Sleep -Seconds \$shutdownDelay.TotalSeconds
    Stop-Computer -Force
"@
    $shutdownScript | Out-File -FilePath "$env:TEMP\ShutdownScript.ps1" -Encoding ASCII
    schtasks /Create /SC ONCE /TN "ShutdownTask" /TR "powershell -ExecutionPolicy Bypass -File `"$env:TEMP\ShutdownScript.ps1`"" /ST $shutdownTime /F
    Write-Host "Shutdown task scheduled for $shutdownTime."
} else {
    Write-Host "The specified shutdown time is in the past. Please enter a future time."
}
