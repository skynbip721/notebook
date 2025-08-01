@echo off
setlocal enabledelayedexpansion

REM 检查管理员权限
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo 请以管理员身份运行此脚本！
    pause
    exit /b
)

REM 设置输出文件路径
set "output=%USERPROFILE%\Desktop\System_Info.txt"

echo 正在收集系统信息，请稍候...
echo 这可能需要几分钟时间...

REM 系统基本信息
echo ====== 系统摘要信息 ====== > %output%
systeminfo >> %output%

REM 详细的硬件信息
echo. >> %output% & echo. >> %output%
echo ====== 处理器信息 ====== >> %output%
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed,Status /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 内存信息 ====== >> %output%
wmic memorychip get Capacity,PartNumber,Speed,Manufacturer,FormFactor /format:list >> %output%
wmic ComputerSystem get TotalPhysicalMemory /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 主板信息 ====== >> %output%
wmic baseboard get Product,Manufacturer,Version,SerialNumber /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== BIOS 信息 ====== >> %output%
wmic bios get Name,Version,Manufacturer,ReleaseDate,SerialNumber /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 磁盘信息 ====== >> %output%
wmic diskdrive get Model,Size,InterfaceType,MediaType,SerialNumber /format:list >> %output%
echo. >> %output%
wmic logicaldisk where DriveType=3 get DeviceID,Size,FreeSpace /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 显卡信息 ====== >> %output%
wmic path Win32_VideoController get Name,AdapterRAM,DriverVersion /format:list >> %output%

REM 网络信息
echo. >> %output% & echo. >> %output%
echo ====== 网络适配器信息 ====== >> %output%
wmic nicconfig where "IPEnabled=true" get MACAddress,IPAddress,DNSHostName,DefaultIPGateway,DNSServerSearchOrder /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 详细网络配置 ====== >> %output%
ipconfig /all >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 路由表 ====== >> %output%
route print >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ARP缓存 ====== >> %output%
arp -a >> %output%

echo. >> %output% & echo. >> %output%
echo ====== 网络连接状态 ====== >> %output%
netstat -ano >> %output%

REM 驱动程序信息
echo. >> %output% & echo. >> %output%
echo ====== 已安装驱动程序 ====== >> %output%
driverquery /v >> %output%

echo 信息收集完成！
echo 报告已保存到桌面：%output%
pause