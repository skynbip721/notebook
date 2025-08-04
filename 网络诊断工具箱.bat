@echo off
setlocal enabledelayedexpansion
color 0a
title 网络诊断工具箱 v1.0

:MAIN
cls
echo.
echo  网络诊断工具箱
echo  ========================
echo  1. 显示IP信息
echo  2. 网络连通性测试
echo  3. WebRTC检测
echo  4. DNS泄漏测试
echo  5. 网速测试
echo  6. 高级工具
echo  7. 退出
echo  ========================
set /p choice=请选择功能 [1-7]: 

goto MENU%choice%

:MENU1
cls
echo 正在获取网络信息...
echo ========================
echo 【本地网络信息】
ipconfig | findstr /i "IPv4 子网掩码 默认网关"
echo.

echo 【公网IP信息】
curl -s https://api.ipify.org
echo.
echo ========================
pause
goto MAIN

:MENU2
cls
echo 正在执行网络连通性测试...
echo ========================
echo 测试网关连通性...
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr "默认网关"') do ping %%i -n 4

echo.
echo 测试互联网连通性...
ping 8.8.8.8 -n 4 | findstr "统计信息"
ping 114.114.114.114 -n 4 | findstr "统计信息"
ping www.baidu.com -n 4 | findstr "统计信息"
echo ========================
pause
goto MAIN

:MENU3
cls
echo 正在准备WebRTC检测...
echo ========================
echo 请使用浏览器访问以下地址进行测试：
echo https://webrtc-test.net
echo.
start https://webrtc-test.net
pause
goto MAIN

:MENU4
cls
echo 正在准备DNS泄漏测试...
echo ========================
echo 请使用浏览器访问以下地址：
echo https://www.dnsleaktest.com
echo.
start https://www.dnsleaktest.com
pause
goto MAIN

:MENU5
cls
echo 请选择测速方式：
echo 1) 网页版Speedtest
echo 2) 命令行测速（需安装speedtest-cli）
set /p speed=选择[1-2]: 

if %speed%==1 (
    start https://www.speedtest.net/
) else if %speed%==2 (
    echo 正在测试网络速度...
    speedtest-cli --simple
)
pause
goto MAIN

:MENU6
cls
echo 高级工具
echo ========================
echo 1) 路由跟踪
echo 2) DNS查询
echo 3) 端口扫描
echo 4) 返回主菜单
set /p adv=请选择工具[1-4]: 

if %adv%==1 (
    set /p target=请输入跟踪目标: 
    tracert !target!
    pause
    goto MENU6
)

if %adv%==2 (
    set /p domain=请输入查询域名: 
    nslookup !domain! 8.8.8.8
    nslookup !domain! 114.114.114.114
    pause
    goto MENU6
)

if %adv%==3 (
    set /p target=请输入扫描目标: 
    set /p ports=请输入端口范围(例 80-100): 
    echo 正在扫描!target! 端口!ports!...
    powershell -command "$target='!target!'; $ports=!ports! -split '-'; foreach ($port in $ports[0]..$ports[1]) {Test-NetConnection $target -Port $port | Where-Object {$_.TcpTestSucceeded}}"
    pause
    goto MENU6
)

goto MAIN

:MENU7
exit

:ERROR
echo 无效输入，请重新选择!
pause
goto MAIN