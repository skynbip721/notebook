@echo off
setlocal enabledelayedexpansion
title 电脑信息查询工具
color 0A

:: 定义输出文件路径
set "outputFile=%USERPROFILE%\Desktop\电脑信息.txt"
echo ===== 系统配置信息 ===== > "%outputFile%"
echo 生成时间: %date% %time% >> "%outputFile%"
echo ======================== >> "%outputFile%"

:: 一、基础系统信息
echo [1](@ref)系统基础信息 >> "%outputFile%"
systeminfo | findstr /C:"OS 名称" /C:"OS 版本" /C:"系统制造商" /C:"系统型号" >> "%outputFile%"
echo. >> "%outputFile%"

:: 二、硬件详细信息
echo [2](@ref)硬件配置信息 >> "%outputFile%"
echo ------------------------ >> "%outputFile%"
echo 主板信息: >> "%outputFile%"
wmic baseboard get manufacturer,product,version,serialnumber >> "%outputFile%"
echo. >> "%outputFile%"

echo CPU信息: >> "%outputFile%"
wmic cpu get name,numberofcores,numberoflogicalprocessors,maxclockspeed >> "%outputFile%"
echo. >> "%outputFile%"

echo 内存信息: >> "%outputFile%"
wmic memorychip get manufacturer,partnumber,capacity,serialnumber >> "%outputFile%"
echo. >> "%outputFile%"

echo 硬盘信息: >> "%outputFile%"
wmic diskdrive get model,size,serialnumber >> "%outputFile%"
echo. >> "%outputFile%"

echo 显卡信息: >> "%outputFile%"
wmic path win32_videocontroller get name,adapterram >> "%outputFile%"
echo. >> "%outputFile%"

:: 三、网络接入信息
echo [3](@ref)网络连接信息 >> "%outputFile%"
echo ==================== >> "%outputFile%"

echo 当前IP配置: >> "%outputFile%"
ipconfig | findstr /C:"IPv4 地址" /C:"子网掩码" /C:"默认网关" >> "%outputFile%"

echo DNS服务器配置: >> "%outputFile%"
ipconfig /all | findstr /C:"DNS 服务器" >> "%outputFile%"

echo 物理网卡信息: >> "%outputFile%"
getmac /v | findstr /C:"物理地址" /C:"连接名称" >> "%outputFile%"

:: 四、网络连通性检测
echo [4](@ref)网络连通性测试 >> "%outputFile%"
echo ================== >> "%outputFile%"
echo 测试外网连通性: >> "%outputFile%"
ping www.baidu.com -n 3 | findstr "时间=" >> "%outputFile%"
echo. >> "%outputFile%"

echo 路由追踪测试: >> "%outputFile%"
tracert www.baidu.com | findstr "1" >> "%outputFile%"
echo. >> "%outputFile%"

:: 清理临时文件
del /f "%TEMP%\*.tmp" 2>nul

echo 信息收集完成！按任意键退出...
pause >nul
exit