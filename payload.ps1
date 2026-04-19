$targetPath = "C:\Lab\ProtectedDemo\pwned.txt"
try {
    "Pwned by PowerShell Lab" | Out-File -FilePath $targetPath -Force
    Write-Host "------------------------------------------" -ForegroundColor Green
    Write-Host "[+] Attack Successful! File created." -ForegroundColor Green
    Write-Host "[+] Path: $targetPath" -ForegroundColor Cyan
    Write-Host "------------------------------------------"
} catch {
    Write-Host "------------------------------------------" -ForegroundColor Red
    Write-Host "[!] Access Denied: Cannot write to folder." -ForegroundColor Red
    Write-Host "------------------------------------------"
}
# Optional: Clear history
Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue
