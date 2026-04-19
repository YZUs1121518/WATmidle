# GitHub 檔案內容：payload.ps1
$targetPath = "C:\Lab\ProtectedDemo\pwned.txt"

try {
    # 嘗試建立檔案
    New-Item -Path $targetPath -ItemType File -Force -ErrorAction Stop | Out-Null
    
    $status = "[+] 成功繞過權限或以高權限執行！"
    $color = "Green"
} catch {
    $status = "[!] 寫入失敗：權限不足 (Access Denied)"
    $color = "Red"
}

# 顯示結果
Write-Host "------------------------------------------"
Write-Host $status -ForegroundColor $color
Write-Host "[+] 嘗試路徑: $targetPath" -ForegroundColor Cyan
Write-Host "------------------------------------------"

# 清除歷史紀錄
Remove-Item (Get-PSReadlineOption).HistorySavePath -ErrorAction SilentlyContinue
