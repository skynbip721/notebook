@ECHO OFF & setlocal enabledelayedexpansion

:: ��ȡ����·��
set "desktopPath=%USERPROFILE%\Desktop"
set "outputFile=%desktopPath%\������������Ϣ.txt"

TITLE ��ʾ���������ӵ�����������Ϣ by.52Echo
mode con: cols=80 lines=30

REM ��ȡ����IPv4��IPv6��ַ
for /f "delims=" %%a in ('curl -s https://ipv4.icanhazip.com') do set "PublicIPv4=%%a"
for /f "delims=" %%a in ('curl -s https://ipv6.icanhazip.com') do set "PublicIPv6=%%a"

REM ��ȡ����IP��Ӫ����Ϣ
call :get_ISP_info %PublicIPv4%

REM ��ʾ����������Ϣ
CALL :get_NIC_info

REM ��ʾ������Ϣ
ECHO ---------------------------------------------------
ECHO ������Ϣ:
ECHO   ����IPv4��ַ    : %PublicIPv4%
ECHO   ����IPv6��ַ    : %PublicIPv6%
ECHO   ������Ӫ��      : %ISP%

pause>nul
EXIT /B 0

:get_NIC_info
SET "_i_=0"

ECHO ���������ӵ�����������Ϣ��δ�����߲�����ʾ���·���:
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
            ECHO   ����         : !Description!
            ECHO   MAC �����ַ : !MACAddress!
            ECHO   IPv4 ��ַ    : !IPAddress!
            ECHO   ��������     : !IPSubnet!
            ECHO   Ĭ������     : !DefaultIPGateway!
            ECHO   DNS ������   : !DNSServerSearchOrder!
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
ECHO �����ӵ�������������: %_i_%
GOTO:EOF

:trim_IP
(set %1=!%1:^"=!&set %1=!%1:{=!&set %1=!%1:}=!)
IF /i "%1"=="IPAddress" for /f "delims=," %%a in ("!%1!") do set "%1=%%a"
IF /i "%1"=="IPSubnet" for /f "delims=," %%a in ("!%1!") do set "%1=%%a"
GOTO:EOF

:get_ISP_info
setlocal
set "ip=%1"
set "ISP=δ֪"
if "%ip%"=="" endlocal & goto :EOF
call :is_private %ip%
if %errorlevel% equ 1 (
    set "ISP=��������"
) else (
    for /f "tokens=*" %%i in ('curl -s https://ipinfo.io/%ip%/org') do set "ISP=%%i"
    if "!ISP!"=="" set "ISP=��ѯʧ��"
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