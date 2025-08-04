@echo off
color 1F
title 系统信息扫描器

echo.
echo ================================================
echo        系统硬件与网络信息扫描器
echo ================================================
echo.

:: 硬件信息部分
echo [1/4] 正在获取硬件信息...
echo.

:: 操作系统信息
echo 操作系统信息:
systeminfo | findstr /B /C:"OS 名称" /C:"OS 版本" /C:"系统制造商" /C:"系统类型"
echo.

:: CPU信息
echo 处理器信息:
wmic cpu get name,NumberOfCores,NumberOfLogicalProcessors /format:table | findstr /V "Name"
echo.

:: 内存信息
echo 物理内存信息:
wmic memorychip get Capacity,MemoryType,Speed /format:table | findstr /V "Capacity"
echo.

:: 硬盘信息
echo 磁盘信息:
wmic diskdrive get size,model,serialnumber /format:table | findstr /V "Size"
echo.

:: 主板信息
echo 主板信息:
wmic baseboard get product,manufacturer,version,serialnumber /format:table | findstr /V "Product"
echo.

:: 网络信息部分
echo [2/4] 正在获取网络信息...
echo.

:: IP配置
echo IP地址信息:
ipconfig | findstr /V "IPv6" | findstr /V "媒体状态"
echo.

:: MAC地址
echo 网络适配器MAC地址:
getmac /v | findstr /V "MAC Address"
echo.

:: 网关和DNS
echo 网关和DNS信息:
ipconfig /all | findstr /C:"默认网关" /C:"DNS 服务器"
echo.

:: 网络连接状态
echo 网络连接状态:
netsh wlan show profiles
echo.

:: 系统信息补充
echo [3/4] 补充系统信息...
echo.

:: 环境变量
echo 系统环境路径:
echo %PATH% | more
echo.

:: 补丁信息
echo 已安装更新:
wmic qfe list brief /format:table | findstr /V "HotFixID"
echo.

:: 系统启动时间
echo 系统启动时间:
systeminfo | find "系统启动时间"
echo.

:: 网络测试部分
echo [4/4] 正在执行网络测试...
echo.

:: Ping测试
echo 正在测试网络连接...
ping -n 3 www.baidu.com > nul
if errorlevel 1 (
    echo 网络连接测试失败，请检查网络设置
) else (
    echo 网络连接正常
)
echo.

:: Traceroute
echo 正在执行路由追踪...
tracert -d www.baidu.com | findstr /V "跟踪路由"
echo.

pause
exit