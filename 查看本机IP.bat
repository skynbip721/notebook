@ECHO OFF & setlocal enabledelayedexpansion
TITLE ��ʾ���������ӵ�����������Ϣ by.52Echo
mode con: cols=80 lines=30
CALL :get_NIC_info
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
