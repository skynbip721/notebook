@echo off & setlocal enabledelayedexpansion
:: �������ԱȨ��
%1 mshta vbscript:CreateObject("Shell.Application").ShellExecute("cmd.exe","/c %~s0 ::","","runas",1)(window.close)&&exit

:: �������·��
set "outfile=%USERPROFILE%\Desktop\ϵͳ��Ϣ����.txt"
echo ==== ϵͳӲ����ⱨ�� ==== > "%outfile%"
echo ����ʱ��: %date% %time% >> "%outfile%"
echo ========================== >> "%outfile%"

:: ������Ϣ
echo [������Ϣ] >> "%outfile%"
wmic baseboard get Manufacturer,Product,Version,SerialNumber /value >> "%outfile%"
echo. >> "%outfile%"

:: CPU��Ϣ
echo [CPU��Ϣ] >> "%outfile%"
wmic cpu get Name,NumberOfCores,MaxClockSpeed,Status /value >> "%outfile%"
echo. >> "%outfile%"

:: �ڴ���Ϣ
echo [�ڴ���Ϣ] >> "%outfile%"
wmic memorychip get Manufacturer,PartNumber,Capacity,Speed /value >> "%outfile%"
echo. >> "%outfile%"

:: Ӳ����Ϣ
echo [�洢�豸] >> "%outfile%"
wmic diskdrive get Model,Size,InterfaceType,MediaType /value >> "%outfile%"
echo. >> "%outfile%"

:: �Կ���Ϣ
echo [��ʾ������] >> "%outfile%"
wmic path win32_videocontroller get Name,AdapterRAM,DriverVersion /value >> "%outfile%"
echo. >> "%outfile%"

:: ������ģ��
echo ==== �������ü�� ==== >> "%outfile%"

:: IP��MAC��ַ
echo [����������] >> "%outfile%"
getmac /v /fo list >> "%outfile%"
ipconfig /all | findstr /i "IPv4 �������� Ĭ������ DNS" >> "%outfile%"
echo. >> "%outfile%"

:: ·�ɱ�
echo [·�ɱ�] >> "%outfile%"
route print | findstr /r "^ *0.0.0.0 ^ *172. ^ *192. ^ *10." >> "%outfile%"
echo. >> "%outfile%"

:: ������ͨ��
echo [��������] >> "%outfile%"
ping -n 3 www.baidu.com | findstr "TTL" >> "%outfile%"
tracert -d -h 3 www.baidu.com | findstr "[0-9]" >> "%outfile%"

:: �����������ʾ
del /q %temp%\*.tmp >nul 2>&1
echo ����������������[ϵͳ��Ϣ����.txt]
pause