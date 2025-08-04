@ECHO OFF & setlocal enabledelayedexpansion
TITLE 显示所有已连接的网络连接信息 by.52Echo
mode con: cols=80 lines=30
CALL :get_NIC_info
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
