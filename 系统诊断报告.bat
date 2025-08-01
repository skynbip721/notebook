@echo off
setlocal enabledelayedexpansion

:: 设置保存路径和文件名
set "savePath=%USERPROFILE%\Desktop\"
set "fileName=System_Diagnostic_Report_$(date /T | find "2023").txt"
set "saveFile=%savePath%%fileName%"

:: 获取当前日期和时间，格式化文件名
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set "fileName=System_Diagnostic_Report_%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%.txt"
set "saveFile=%savePath%%fileName%"

:: 开始记录
echo 系统诊断报告 > "%saveFile%"
echo ================================ >> "%saveFile%"
echo 日期和时间: %date% %time% >> "%saveFile%"
echo ================================ >> "%saveFile%"

:: 系统信息
echo. >> "%saveFile%"
echo 系统信息 >> "%saveFile%"
echo ---------------- >> "%saveFile%"
systeminfo >> "%saveFile%"

:: 硬件检测
echo. >> "%saveFile%"
echo 硬件信息 >> "%saveFile%"
echo ---------------- >> "%saveFile%"
echo. >> "%saveFile%"

echo 处理器信息 >> "%saveFile%"
wmic cpu get name, numberofcores, numberoflogicalprocessors >> "%saveFile%"

echo. >> "%saveFile%"
echo 内存信息 >> "%saveFile%"
wmic memorychip get capacity, speed >> "%saveFile%"

echo. >> "%saveFile%"
echo 硬盘信息 >> "%saveFile%"
wmic diskdrive get model, size, serialnumber >> "%saveFile%"

echo. >> "%saveFile%"
echo 显卡信息 >> "%saveFile%"
wmic path win32_videocontroller get name, driverversion >> "%saveFile%"

echo. >> "%saveFile%"
echo 主板信息 >> "%saveFile%"
wmic baseboard get product, manufacturer, serialnumber >> "%saveFile%"

:: 网络检测
echo. >> "%saveFile%"
echo 网络信息 >> "%saveFile%"
echo ---------------- >> "%saveFile%"

echo IP配置 >> "%saveFile%"
ipconfig /all >> "%saveFile%"

echo. >> "%saveFile%"
echo 网络连接状态 >> "%saveFile%"
netstat -ano >> "%saveFile%"

echo. >> "%saveFile%"
echo 测试网络连接 >> "%saveFile%"
ping -4 www.google.com -n 4 >> "%saveFile%"
ping -4 www.baidu.com -n 4 >> "%saveFile%"

:: 安全检测
echo. >> "%saveFile%"
echo 安全信息 >> "%saveFile%"
echo ---------------- >> "%saveFile%"

echo 防病毒软件状态 >> "%saveFile%"
tasklist | findstr /i "msmpeng.exe" >> "%saveFile%"
tasklist | findstr /i "Avg" >> "%saveFile%"
tasklist | findstr /i "Avast" >> "%saveFile%"
tasklist | findstr /i "Norton" >> "%saveFile%"
tasklist | findstr /i "McAfee" >> "%saveFile%"
tasklist | findstr /i "Bitdefender" >> "%saveFile%"
tasklist | findstr /i "Kaspersky" >> "%saveFile%"

echo. >> "%saveFile%"
echo 系统更新状态 >> "%saveFile%"
wmic qfe list brief >> "%saveFile%"

echo. >> "%saveFile%"
echo 用户账户信息 >> "%saveFile%"
net user >> "%saveFile%"

echo. >> "%saveFile%"
echo 防火墙状态 >> "%saveFile%"
netsh advfirewall show allprofiles >> "%saveFile%"

:: 完成
echo. >> "%saveFile%"
echo ================================ >> "%saveFile%"
echo 诊断报告已保存到: %saveFile% >> "%saveFile%"
echo ================================ >> "%saveFile%"

echo 诊断报告已保存到: %saveFile%
start "" "%saveFile%"