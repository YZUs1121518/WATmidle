# 1. 初始化與環境變數
$taskName = "SecurityUpdate"
$workDir = "$env:TEMP\SecurityLab"
if (!(Test-Path $workDir)) { New-Item -Path $workDir -ItemType Directory | Out-Null }
$logFile = "$env:USERPROFILE\Desktop\Attack_Report.txt"

# 2. 顯示美化的 Terminal
Clear-Host
Write-Host "==========================================" -ForegroundColor Red
Write-Host "      [!] 高級持續性威脅 (APT) 模擬中      " -ForegroundColor White -BackgroundColor DarkRed
Write-Host "==========================================" -ForegroundColor Red

# --- 動作 A: 系統偵察 (Reconnaissance) ---
Write-Host "[*] 正在蒐集系統情報..." -ForegroundColor Cyan
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -like "*Wi-Fi*" -or $_.InterfaceAlias -like "*Ethernet*" }).IPAddress[0]
$userPriv = if ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent().IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) { "Admin" } else { "User" }

$sysInfo = @"
[系統情報]
主機名稱: $env:COMPUTERNAME
當前用戶: $env:USERNAME (權限: $userPriv)
內部 IP: $ip
作業系統: $((Get-WmiObject Win32_OperatingSystem).Caption)
"@
$sysInfo | Out-File -FilePath $logFile -Force

# --- 動作 B: 敏感檔案掃描 (Discovery) ---
Write-Host "[*] 正在掃描桌面敏感檔案 (.txt, .docx)..." -ForegroundColor Cyan
$sensitiveFiles = Get-ChildItem -Path "$env:USERPROFILE\Desktop" -Include *.txt, *.docx -Recurse -ErrorAction SilentlyContinue | Select-Object -First 5 Name
$fileList = $sensitiveFiles.Name -join ", "
"發現潛在敏感檔案: $fileList" | Out-File -FilePath $logFile -Append

# --- 動作 C: 螢幕截圖模擬 (Spyware Behavior) ---
# 這裡使用 PowerShell 呼叫 .NET 進行螢幕截圖並存入 TEMP 資料夾
Write-Host "[*] 正在截取當前螢幕畫面 (Spyware)..." -ForegroundColor Cyan
try {
    Add-Type -AssemblyName System.Windows.Forms, System.Drawing
    $Screen = [System.Windows.Forms.Screen]::PrimaryScreen
    $Bitmap = New-Object System.Drawing.Bitmap($Screen.Bounds.Width, $Screen.Bounds.Height)
    $Graphics = [System.Drawing.Graphics]::FromImage($Bitmap)
    $Graphics.CopyFromScreen($Screen.Bounds.X, $Screen.Bounds.Y, 0, 0, $Bitmap.Size)
    $Bitmap.Save("$workDir\screenshot.png", [System.Drawing.Imaging.ImageFormat]::Png)
    $Graphics.Dispose(); $Bitmap.Dispose()
    "螢幕截圖已存儲於: $workDir\screenshot.png" | Out-File -FilePath $logFile -Append
} catch { "截圖失敗: 權限或環境限制" | Out-File -FilePath $logFile -Append }

# --- 動作 D: 模擬資料回傳 (Beaconing) ---
Write-Host "------------------------------------------"
Write-Host "正在建立與 C2 伺服器的加密隧道..." -ForegroundColor DarkGray
for ($i=1; $i -le 5; $i++) {
    $size = Get-Random -Minimum 100 -Maximum 999
    Write-Host ">> 正在傳送加密數據包 ($size KB)... 成功" -ForegroundColor DarkCyan
    Start-Sleep -Seconds 3
}

Write-Host "`n[+] 攻擊演示完成。報告已產出至桌面。" -ForegroundColor Green
Write-Host "[!] 提示: 實際攻擊中，上述行為皆會在背景靜默完成。" -ForegroundColor Yellow
Start-Sleep -Seconds 5
