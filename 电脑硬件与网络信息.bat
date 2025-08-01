@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion
title 电脑硬件与网络信息收集工具
mode con cols=120 lines=60
color 0A

:: 设置输出文件路径（桌面）
set "outputFile=%USERPROFILE%\Desktop\电脑硬件与网络信息_%DATE:~0,4%%DATE:~5,2%%DATE:~8,2%.txt"

:: 确保WMI服务正常运行
sc config winmgmt start= auto >nul 2>&1
net start winmgmt >nul 2>&1

:: 清空或创建输出文件
if exist "%outputFile%" del "%outputFile%"

:: ===== 1. 系统基础信息（中文属性） =====
echo ====================== 系统基本信息 ====================== >> "%outputFile%"
for /f "tokens=*" %%a in ('wmic computersystem get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="Name" set "sysName=%%c"
        if "%%b"=="UserName" set "userName=%%c"
        if "%%b"=="Domain" set "domain=%%c"
        if "%%b"=="Workgroup" set "workgroup=%%c"
        if "%%b"=="SystemType" set "systemType=%%c"
    )
)
echo 计算机名称: %sysName% >> "%outputFile%"
echo 当前用户: %userName% >> "%outputFile%"
echo 所属域/工作组: %domain%/%workgroup% >> "%outputFile%"
echo 系统类型: %systemType% >> "%outputFile%"

for /f "tokens=*" %%a in ('wmic os get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="Caption" set "osName=%%c"
        if "%%b"=="Version" set "osVersion=%%c"
        if "%%b"=="InstallDate" set "installDate=%%c"
        if "%%b"=="TotalVisibleMemorySize" set "totalMemMB=%%c"
    )
)
echo 操作系统: %osName% >> "%outputFile%"
echo 系统版本: %osVersion% >> "%outputFile%"
echo 安装日期: %installDate% >> "%outputFile%"
set /a totalMemGB=!totalMemMB!/1024
echo 总内存: !totalMemGB! GB >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 2. 主板与BIOS信息（中文属性） =====
echo ====================== 主板与BIOS信息 ====================== >> "%outputFile%"
for /f "tokens=*" %%a in ('wmic baseboard get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="Manufacturer" set "mbMaker=%%c"
        if "%%b"=="Product" set "mbModel=%%c"
        if "%%b"=="SerialNumber" set "mbSN=%%c"
    )
)
echo 主板制造商: %mbMaker% >> "%outputFile%"
echo 主板型号: %mbModel% >> "%outputFile%"
echo 主板序列号: %mbSN% >> "%outputFile%"

for /f "tokens=*" %%a in ('wmic bios get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="Manufacturer" set "biosMaker=%%c"
        if "%%b"=="Name" set "biosName=%%c"
        if "%%b"=="ReleaseDate" set "biosDate=%%c"
    )
)
echo BIOS制造商: %biosMaker% >> "%outputFile%"
echo BIOS版本: %biosName% >> "%outputFile%"
echo BIOS发布日期: %biosDate% >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 3. CPU信息（中文属性） =====
echo ====================== CPU信息 ====================== >> "%outputFile%"
for /f "tokens=*" %%a in ('wmic cpu get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="Name" set "cpuName=%%c"
        if "%%b"=="NumberOfCores" set "cpuCores=%%c"
        if "%%b"=="NumberOfLogicalProcessors" set "cpuThreads=%%c"
        if "%%b"=="MaxClockSpeed" set "cpuMaxSpeed=%%c"
    )
)
echo CPU型号: %cpuName% >> "%outputFile%"
echo 物理核心数: %cpuCores% >> "%outputFile%"
echo 逻辑线程数: %cpuThreads% >> "%outputFile%"
echo 最大主频: %cpuMaxSpeed% MHz >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 4. 内存信息（中文属性） =====
echo ====================== 内存信息 ====================== >> "%outputFile%"
echo 内存条详细信息: >> "%outputFile%"
wmic memorychip get Capacity^,Speed^,Manufacturer^,PartNumber /format:list >> "%outputFile%"
set /a totalMemGB=!totalMemMB!/1024
echo 总内存容量: !totalMemGB! GB >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 5. 存储设备信息（中文属性） =====
echo ====================== 存储设备 ====================== >> "%outputFile%"
echo 物理硬盘信息: >> "%outputFile%"
wmic diskdrive get Model^,InterfaceType^,Size^,Partitions /format:list >> "%outputFile%"

echo 逻辑分区信息: >> "%outputFile%"
wmic logicaldisk where "drivetype=3" get DeviceID^,FileSystem^,Size^,FreeSpace /format:list >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 6. 显卡信息（中文属性） =====
echo ====================== 显卡信息 ====================== >> "%outputFile%"
for /f "tokens=*" %%a in ('wmic path Win32_VideoController get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="Name" set "gpuName=%%c"
        if "%%b"=="AdapterRAM" set "gpuRAM=%%c"
        if "%%b"=="CurrentHorizontalResolution" set "gpuResX=%%c"
        if "%%b"=="CurrentVerticalResolution" set "gpuResY=%%c"
    )
)
echo 显卡型号: %gpuName% >> "%outputFile%"
echo 显存容量: %gpuRAM% bytes (~%gpuRAM:~0,-6% MB) >> "%outputFile%"
echo 当前分辨率: %gpuResX%x%gpuResY% >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 7. 外接设备信息（中文属性） =====
echo ====================== 外接设备 ====================== >> "%outputFile%"
echo USB设备列表: >> "%outputFile%"
wmic path Win32_USBControllerDevice get Dependent /format:list >> "%outputFile%"

echo 打印机列表: >> "%outputFile%"
wmic printer get Name^,Default /format:list >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 8. 本地网络配置（中文属性） =====
echo ====================== 本地网络配置 ====================== >> "%outputFile%"
echo IP与MAC地址信息: >> "%outputFile%"
for /f "tokens=*" %%a in ('wmic nicconfig where "IPEnabled='True'" get /value ^| findstr /r /v "^$"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="IPAddress" set "ip=%%c"
        if "%%b"=="MACAddress" set "mac=%%c"
        if "%%b"=="Description" set "netDesc=%%c"
    )
)
echo 本地IP地址: %ip% >> "%outputFile%"
echo MAC地址: %mac% >> "%outputFile%"
echo 网卡描述: %netDesc% >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 9. 公网IP与运营商信息（新增） =====
echo ====================== 公网IP与运营商信息 ====================== >> "%outputFile%"
echo 正在获取公网IP及运营商信息... >> "%outputFile%"

:: 方法1：通过ipinfo.io获取（推荐）
echo [通过ipinfo.io查询] >> "%outputFile%"
for /f "delims=" %%a in ('powershell -command "(Invoke-WebRequest -Uri ' https://ipinfo.io/json ' -UseBasicParsing).Content | ConvertFrom-Json | Select-Object ip, org, city, region, country"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="ip" set "publicIP=%%c"
        if "%%b"=="org" set "ispInfo=%%c"
        if "%%b"=="city" set "city=%%c"
        if "%%b"=="region" set "region=%%c"
        if "%%b"=="country" set "country=%%c"
    )
)
echo 公网IP地址: %publicIP% >> "%outputFile%"
echo 运营商信息: %ispInfo% >> "%outputFile%"
echo 所在城市: %city% >> "%outputFile%"
echo 所在地区: %region% >> "%outputFile%"
echo 所在国家: %country% >> "%outputFile%"
echo. >> "%outputFile%"

:: 方法2：通过ip-api.com获取（备用）
echo [通过ip-api.com查询] >> "%outputFile%"
for /f "delims=" %%a in ('powershell -command "(Invoke-WebRequest -Uri ' http://ip-api.com/json ' -UseBasicParsing).Content | ConvertFrom-Json | Select-Object query, isp, city, regionName, country"') do (
    for /f "tokens=1,* delims==" %%b in ("%%a") do (
        if "%%b"=="query" set "publicIP2=%%c"
        if "%%b"=="isp" set "ispInfo2=%%c"
        if "%%b"=="city" set "city2=%%c"
        if "%%b"=="regionName" set "region2=%%c"
        if "%%b"=="country" set "country2=%%c"
    )
)
echo 公网IP地址(备用): %publicIP2% >> "%outputFile%"
echo 运营商信息(备用): %ispInfo2% >> "%outputFile%"
echo 所在城市(备用): %city2% >> "%outputFile%"
echo 所在地区(备用): %region2% >> "%outputFile%"
echo 所在国家(备用): %country2% >> "%outputFile%"
echo. >> "%outputFile%"

:: ===== 10. 局域网设备扫描（中文提示） =====
echo ====================== 局域网设备扫描 ====================== >> "%outputFile%"
echo 正在扫描同一局域网内的其他设备... >> "%outputFile%"
for /f "tokens=1 delims=." %%a in ('wmic nicconfig where "IPEnabled='True'" get IPAddress /value ^| findstr "[0-9]"') do (
    set "subnet=%%a"
    goto :scan
)
:scan
echo 扫描网段: !subnet!.0/24 >> "%outputFile%"
nbtscan !subnet!.0/24 >> "%outputFile%" 2>&1
echo. >> "%outputFile%"

:: 完成提示（中文）
echo ====================== 信息收集完成 ====================== >> "%outputFile%"
echo 所有硬件与网络信息已保存至: %outputFile%
echo.
echo 按任意键退出...
pause >nul
