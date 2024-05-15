$interval = 60  # 检查间隔
$python_path = "path/to/python.exe"  # python路径
$py_file = "auto_connect.py"  # python文件路径

$ProgressPreference = 'SilentlyContinue'  # powershell 1.0：防止出现进度条
do {
    # 查看WiFi是不是打开的
    $wifi_status = (Get-NetAdapter -Name WLAN).Status
    if ($wifi_status -ne "Up") {
        Write-Host "WiFi is not up"
        continue
    }
    $wifi_name = (Get-NetConnectionProfile -InterfaceAlias WLAN).Name
    # 如果不是HUST_WIRELESS，跳过
    if ($wifi_name -ne "HUST_WIRELESS") {
        Write-Host "WiFi is not HUST_WIRELESS"
        continue
    }
    # $ping_res = Test-Connection -ComputerName "baidu.com" -Count 1 -Quiet
    $response = Invoke-WebRequest -Uri "http://www.baidu.com" -Method Head -UseBasicParsing
    if ($response.Content -eq "") {
        Write-Host "Internet OK"
        continue
    }
    & $python_path $py_file

}while ((Start-Sleep -Seconds $interval) -or $true)