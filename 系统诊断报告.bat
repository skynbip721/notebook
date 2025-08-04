@echo off
setlocal enabledelayedexpansion

:: ���ñ���·�����ļ���
set "savePath=%USERPROFILE%\Desktop\"
set "fileName=System_Diagnostic_Report_$(date /T | find "2023").txt"
set "saveFile=%savePath%%fileName%"

:: ��ȡ��ǰ���ں�ʱ�䣬��ʽ���ļ���
for /f "tokens=2 delims==" %%i in ('wmic os get localdatetime /value') do set datetime=%%i
set "fileName=System_Diagnostic_Report_%datetime:~0,4%-%datetime:~4,2%-%datetime:~6,2%_%datetime:~8,2%-%datetime:~10,2%-%datetime:~12,2%.txt"
set "saveFile=%savePath%%fileName%"

:: ��ʼ��¼
echo ϵͳ��ϱ��� > "%saveFile%"
echo ================================ >> "%saveFile%"
echo ���ں�ʱ��: %date% %time% >> "%saveFile%"
echo ================================ >> "%saveFile%"

:: ϵͳ��Ϣ
echo. >> "%saveFile%"
echo ϵͳ��Ϣ >> "%saveFile%"
echo ---------------- >> "%saveFile%"
systeminfo >> "%saveFile%"

:: Ӳ�����
echo. >> "%saveFile%"
echo Ӳ����Ϣ >> "%saveFile%"
echo ---------------- >> "%saveFile%"
echo. >> "%saveFile%"

echo ��������Ϣ >> "%saveFile%"
wmic cpu get name, numberofcores, numberoflogicalprocessors >> "%saveFile%"

echo. >> "%saveFile%"
echo �ڴ���Ϣ >> "%saveFile%"
wmic memorychip get capacity, speed >> "%saveFile%"

echo. >> "%saveFile%"
echo Ӳ����Ϣ >> "%saveFile%"
wmic diskdrive get model, size, serialnumber >> "%saveFile%"

echo. >> "%saveFile%"
echo �Կ���Ϣ >> "%saveFile%"
wmic path win32_videocontroller get name, driverversion >> "%saveFile%"

echo. >> "%saveFile%"
echo ������Ϣ >> "%saveFile%"
wmic baseboard get product, manufacturer, serialnumber >> "%saveFile%"

:: ������
echo. >> "%saveFile%"
echo ������Ϣ >> "%saveFile%"
echo ---------------- >> "%saveFile%"

echo IP���� >> "%saveFile%"
ipconfig /all >> "%saveFile%"

echo. >> "%saveFile%"
echo ��������״̬ >> "%saveFile%"
netstat -ano >> "%saveFile%"

echo. >> "%saveFile%"
echo ������������ >> "%saveFile%"
ping -4 www.google.com -n 4 >> "%saveFile%"
ping -4 www.baidu.com -n 4 >> "%saveFile%"

:: ��ȫ���
echo. >> "%saveFile%"
echo ��ȫ��Ϣ >> "%saveFile%"
echo ---------------- >> "%saveFile%"

echo ���������״̬ >> "%saveFile%"
tasklist | findstr /i "msmpeng.exe" >> "%saveFile%"
tasklist | findstr /i "Avg" >> "%saveFile%"
tasklist | findstr /i "Avast" >> "%saveFile%"
tasklist | findstr /i "Norton" >> "%saveFile%"
tasklist | findstr /i "McAfee" >> "%saveFile%"
tasklist | findstr /i "Bitdefender" >> "%saveFile%"
tasklist | findstr /i "Kaspersky" >> "%saveFile%"

echo. >> "%saveFile%"
echo ϵͳ����״̬ >> "%saveFile%"
wmic qfe list brief >> "%saveFile%"

echo. >> "%saveFile%"
echo �û��˻���Ϣ >> "%saveFile%"
net user >> "%saveFile%"

echo. >> "%saveFile%"
echo ����ǽ״̬ >> "%saveFile%"
netsh advfirewall show allprofiles >> "%saveFile%"

:: ���
echo. >> "%saveFile%"
echo ================================ >> "%saveFile%"
echo ��ϱ����ѱ��浽: %saveFile% >> "%saveFile%"
echo ================================ >> "%saveFile%"

echo ��ϱ����ѱ��浽: %saveFile%
start "" "%saveFile%"