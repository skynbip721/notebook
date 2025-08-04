@echo off
setlocal enabledelayedexpansion

REM 检查管理员权限
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 请右键以管理员身份运行此脚本！
    pause
    exit /b
)

set "output=%USERPROFILE%\Desktop\Full_System_Report_%DATE:~0,4%-%DATE:~5,2%-%DATE:~8,2%.txt"

echo 正在生成完整系统报告...
echo 可能需要5-10分钟，请勿关闭窗口...

REM ======================
REM 硬件信息收集
REM ======================
echo ====== [硬件信息] ====== > %output%

echo ■ 系统摘要 >> %output%
systeminfo | findstr /B /C:"主机名" /C:"OS 名称" /C:"OS 版本" /C:"系统制造商" /C:"系统型号" >> %output%

echo. >> %output% & echo ■ 处理器信息 >> %output%
wmic cpu get Name,Manufacturer,MaxClockSpeed,NumberOfCores,NumberOfLogicalProcessors /format:list >> %output%

echo. >> %output% & echo ■ 内存详细信息 >> %output%
wmic memorychip get BankLabel,Capacity,PartNumber,Speed,Manufacturer /format:list >> %output%
wmic ComputerSystem get TotalPhysicalMemory | findstr /v "TotalPhysicalMemory" >> %output%

echo. >> %output% & echo ■ 存储设备 >> %output%
wmic diskdrive get Model,Size,InterfaceType,MediaType,SerialNumber /format:list >> %output%
echo -- 分区信息 -- >> %output%
wmic logicaldisk where DriveType=3 get DeviceID,VolumeName,Size,FreeSpace /format:list >> %output%

echo. >> %output% & echo ■ 显卡信息 >> %output%
wmic path Win32_VideoController get Name,AdapterRAM,DriverVersion,CurrentHorizontalResolution,CurrentVerticalResolution /format:list >> %output%

echo. >> %output% & echo ■ 外设列表 >> %output%
wmic printer get Name,PortName,DriverName >> %output%
wmic path Win32_USBControllerDevice get Dependent /format:list >> %output%

REM ======================
REM 网络信息收集
REM ======================
echo. >> %output% & echo. >> %output% & echo ====== [网络信息] ====== >> %output%

echo ■ 网络适配器详细信息 >> %output%
wmic nic get Name,MACAddress,Speed,NetConnectionStatus /format:list >> %output%

echo. >> %output% & echo ■ IP配置详情 >> %output%
ipconfig /all >> %output%

echo. >> %output% & echo ■ 公网IP信息 >> %output%
powershell -c "(Invoke-WebRequest -Uri https://api.ipify.org -UseBasicParsing).Content" >> %output%
echo 备用检测 >> %output%
powershell -c "(Invoke-WebRequest -Uri https://ifconfig.me/ip -UseBasicParsing).Content" >> %output%

echo. >> %output% & echo ■ 网络连通性测试 >> %output%
ping 223.5.5.5 -n 4 >> %output%
ping www.baidu.com -n 4 >> %output%

echo. >> %output% & echo ■ 路由追踪测试 >> %output%
tracert -d 114.114.114.114 >> %output%

echo. >> %output% & echo ■ ARP缓存表 >> %output%
arp -a >> %output%

echo. >> %output% & echo ■ 活动网络连接 >> %output%
netstat -ano -p tcp | findstr "ESTABLISHED" >> %output%

echo. >> %output% & echo ■ 本地服务端口监听 >> %output%
netstat -ano | findstr "LISTENING" >> %output%

REM ======================
REM 局域网扫描
REM ======================
echo. >> %output% & echo. >> %output% & echo ====== [局域网扫描] ====== >> %output%

echo ■ 当前子网设备扫描 >> %output%
set gateway=
for /f "tokens=1-3 delims=: " %%a in ('ipconfig ^| findstr "默认网关"') do set gateway=%%c
echo 默认网关: %gateway% >> %output%

if defined gateway (
   echo 正在扫描%gateway:~0,-3%.0/24子网... >> %output%
   for /L %%i in (1,1,254) do (
      ping -n 1 -w 100 %gateway:~0,-3%.%%i | findstr "TTL=" >nul && echo 活动主机: %gateway:~0,-3%.%%i >> %output%
   )
)

echo. >> %output% & echo ■ 网络共享资源 >> %output%
net view >> %output%

echo. >> %output% & echo ■ SMB会话信息 >> %output%
net session >> %output%

REM ======================
REM 最终处理
REM ======================
echo 报告生成完成！ >> %output%
echo 文件位置: %output%

timeout /t 5 >nul
start notepad %output%
exit