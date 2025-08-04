@echo off & setlocal enabledelayedexpansion
:: 请求管理员权限
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

:: 定义输出路径
set "outfile=%USERPROFILE%\Desktop\系统信息报告.txt"
echo ==== 系统硬件检测报告 ==== > "%outfile%"
echo 生成时间: %date% %time% >> "%outfile%"
echo ========================== >> "%outfile%"

:: 主板信息
echo [主板信息] >> "%outfile%"
wmic baseboard get Manufacturer,Product,Version,SerialNumber /value >> "%outfile%"
echo. >> "%outfile%"

:: CPU信息
echo [CPU信息] >> "%outfile%"
wmic cpu get Name,NumberOfCores,MaxClockSpeed,Status /value >> "%outfile%"
echo. >> "%outfile%"

:: 内存信息
echo [内存信息] >> "%outfile%"
wmic memorychip get Manufacturer,PartNumber,Capacity,Speed /value >> "%outfile%"
echo. >> "%outfile%"

:: 硬盘信息
echo [存储设备] >> "%outfile%"
wmic diskdrive get Model,Size,InterfaceType,MediaType /value >> "%outfile%"
echo. >> "%outfile%"

:: 显卡信息
echo [显示适配器] >> "%outfile%"
wmic path win32_videocontroller get Name,AdapterRAM,DriverVersion /value >> "%outfile%"
echo. >> "%outfile%"

:: 网络检测模块
echo ==== 网络配置检测 ==== >> "%outfile%"

:: IP与MAC地址
echo [网络适配器] >> "%outfile%"
getmac /v /fo list >> "%outfile%"
ipconfig /all | findstr /i "IPv4 子网掩码 默认网关 DNS" >> "%outfile%"
echo. >> "%outfile%"

:: 路由表
echo [路由表] >> "%outfile%"
route print | findstr /r "^ *0.0.0.0 ^ *172. ^ *192. ^ *10." >> "%outfile%"
echo. >> "%outfile%"

:: 外网连通性
echo [外网测试] >> "%outfile%"
ping -n 3 www.baidu.com | findstr "TTL" >> "%outfile%"
tracert -d -h 3 www.baidu.com | findstr "[0-9]" >> "%outfile%"

:: 清理与完成提示
del /q %temp%\*.tmp >nul 2>&1
echo 报告已生成于桌面[系统信息报告.txt]
pause