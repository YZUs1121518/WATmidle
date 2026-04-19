# 1. 取得排程與腳本資訊
$taskName = "SecurityUpdate"
$logFile = "$env:USERPROFILE\Desktop\backdoor_status.txt"
$computerName = $env:COMPUTERNAME

# 2. 顯示美化的 Terminal 介面
Clear-Host
Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "      [!] 後台程式已部署 (模擬環境)      " -ForegroundColor Red
Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "[+] 受害主機: $computerName" -ForegroundColor Cyan
Write-Host "[+] 排程名稱: $taskName" -ForegroundColor Cyan
Write-Host "[+] 執行路徑: C:\Windows\System32\schtasks.exe" -ForegroundColor Gray
Write-Host "[+] 狀態日誌: $logFile" -ForegroundColor Green
Write-Host "------------------------------------------"
Write-Host "程式正在背景持續運作中... 請觀察桌面檔案。" -ForegroundColor White

# 3. 模擬後台持續運作效果 (每 5 秒寫入一次桌面)
$count = 1
while($true) {
    $time = Get-Date -Format "HH:mm:ss"
    "Heartbeat check #$count at $time - System Active" | Out-File -FilePath $logFile -Append
    
    # 這裡可以同步在 Terminal 更新進度，讓你看得到它在動
    Write-Host "[$time] 正在傳送加密封包至 C2 Server... (模擬)" -ForegroundColor DarkGray
    
    if ($count -ge 10) { 
        Write-Host "`n[!] 已完成 10 次模擬行為，為了安全，Demo 結束。" -ForegroundColor Green
        break 
    }
    
    $count++
    Start-Sleep -Seconds 5
}

Write-Host "`n按任意鍵結束視窗..."
Read-Host
