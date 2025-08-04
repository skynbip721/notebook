@ECHO OFF & setlocal enabledelayedexpansion

:: 获取桌面路径
set "desktopPath=%USERPROFILE%\Desktop"
set "outputFile=%desktopPath%\电脑与网络信息.txt"

TITLE 显示所有已连接的网络连接信息 by.52Echo
mode con: cols=80 lines=30

REM 获取公网IPv4和IPv6地址
for /f "delims=" %%a in ('curl -s https://ipv4.icanhazip.com') do set "PublicIPv4=%%a"
for /f "delims=" %%a in ('curl -s https://ipv6.icanhazip.com') do set "PublicIPv6=%%a"

REM 获取公网IP运营商信息
call :get_ISP_info %PublicIPv4%

REM 显示本地网络信息
CALL :get_NIC_info

REM 显示公网信息
ECHO ---------------------------------------------------
ECHO 公网信息:
ECHO   公网IPv4地址    : %PublicIPv4%
ECHO   公网IPv6地址    : %PublicIPv6%
ECHO   网络运营商      : %ISP%

pause>nul
EXIT /B 0

:get_NIC_info
SET "_i_=0"

ECHO 所有已连接的网络连接信息（未插网线不会显示在下方）:
ECHO ---------------------------------------------------
for /f "tokens=1,2 delims==" %%a in ('wmic nic where "NetEnabled='TRUE'" get Index^,MACAddress^,Description^,NetConnectionID /value') do (
    for /f "delims=" %%u in ("%%a") do for /f "delims=" %%v in ("%%b") do (
        IF "%%u" NEQ "" SET "%%u=%%v"
        IF /i "%%u"=="Index" (
            for /f "tokens=1,2 delims==" %%c in ('wmic nicconfig where "Index=!Index!" get IPAddress^,IPSubnet^,DefaultIPGateway^,DNSServerSearchOrder /value') do (
                for /f "delims=" %%x in ("%%c") do for /f "delims=" %%y in ("%%d") do (
                    IF "%%x" NEQ "" SET "%%x=%%y"& CALL :trim_IP %%x
                )
            )
        ) ELSE IF /i "%%u"=="NetConnectionID" (
            REM last value of one NIC here
            SET/a _i_+=1
            ECHO No.!_i_!           : !NetConnectionID!
            ECHO   描述         : !Description!
            ECHO   MAC 物理地址 : !MACAddress!
            ECHO   IPv4 地址    : !IPAddress!
            ECHO   子网掩码     : !IPSubnet!
            ECHO   默认网关     : !DefaultIPGateway!
            ECHO   DNS 服务器   : !DNSServerSearchOrder!
            ECHO ----------------
            SET "MACAddress="
            SET "Description="
            SET "NetConnectionID="
            SET "IPAddress="
            SET "IPSubnet="
            SET "DefaultIPGateway="
            SET "DNSServerSearchOrder="
        )
    )
)
ECHO 已连接的网络连接数量: %_i_%
GOTO:EOF

:trim_IP
(set %1=!%1:^"=!&set %1=!%1:{=!&set %1=!%1:}=!)
IF /i "%1"=="IPAddress" for /f "delims=," %%a in ("!%1!") do set "%1=%%a"
IF /i "%1"=="IPSubnet" for /f "delims=," %%a in ("!%1!") do set "%1=%%a"
GOTO:EOF

:get_ISP_info
setlocal
set "ip=%1"
set "ISP=未知"
if "%ip%"=="" endlocal & goto :EOF
call :is_private %ip%
if %errorlevel% equ 1 (
    set "ISP=本地网络"
) else (
    for /f "tokens=*" %%i in ('curl -s https://ipinfo.io/%ip%/org') do set "ISP=%%i"
    if "!ISP!"=="" set "ISP=查询失败"
)
endlocal & set "ISP=%ISP%"
goto :EOF

:is_private
setlocal
set "ip=%1"
set "is_private=0"
for /f "tokens=1-4 delims=." %%a in ("%ip%") do (
    if "%%a"=="10" set "is_private=1"
    if "%%a"=="172" (
        if %%b geq 16 if %%b leq 31 set "is_private=1"
    )
    if "%%a"=="192" if "%%b"=="168" set "is_private=1"
)
endlocal & exit /b %is_private%