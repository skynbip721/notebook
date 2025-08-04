@echo off
setlocal enabledelayedexpansion

REM ������ԱȨ��
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ���Ҽ��Թ���Ա������д˽ű���
    pause
    exit /b
)

set "output=%USERPROFILE%\Desktop\Full_System_Report_%DATE:~0,4%-%DATE:~5,2%-%DATE:~8,2%.txt"

echo ������������ϵͳ����...
echo ������Ҫ5-10���ӣ�����رմ���...

REM ======================
REM Ӳ����Ϣ�ռ�
REM ======================
echo ====== [Ӳ����Ϣ] ====== > %output%

echo �� ϵͳժҪ >> %output%
systeminfo | findstr /B /C:"������" /C:"OS ����" /C:"OS �汾" /C:"ϵͳ������" /C:"ϵͳ�ͺ�" >> %output%

echo. >> %output% & echo �� ��������Ϣ >> %output%
wmic cpu get Name,Manufacturer,MaxClockSpeed,NumberOfCores,NumberOfLogicalProcessors /format:list >> %output%

echo. >> %output% & echo �� �ڴ���ϸ��Ϣ >> %output%
wmic memorychip get BankLabel,Capacity,PartNumber,Speed,Manufacturer /format:list >> %output%
wmic ComputerSystem get TotalPhysicalMemory | findstr /v "TotalPhysicalMemory" >> %output%

echo. >> %output% & echo �� �洢�豸 >> %output%
wmic diskdrive get Model,Size,InterfaceType,MediaType,SerialNumber /format:list >> %output%
echo -- ������Ϣ -- >> %output%
wmic logicaldisk where DriveType=3 get DeviceID,VolumeName,Size,FreeSpace /format:list >> %output%

echo. >> %output% & echo �� �Կ���Ϣ >> %output%
wmic path Win32_VideoController get Name,AdapterRAM,DriverVersion,CurrentHorizontalResolution,CurrentVerticalResolution /format:list >> %output%

echo. >> %output% & echo �� �����б� >> %output%
wmic printer get Name,PortName,DriverName >> %output%
wmic path Win32_USBControllerDevice get Dependent /format:list >> %output%

REM ======================
REM ������Ϣ�ռ�
REM ======================
echo. >> %output% & echo. >> %output% & echo ====== [������Ϣ] ====== >> %output%

echo �� ������������ϸ��Ϣ >> %output%
wmic nic get Name,MACAddress,Speed,NetConnectionStatus /format:list >> %output%

echo. >> %output% & echo �� IP�������� >> %output%
ipconfig /all >> %output%

echo. >> %output% & echo �� ����IP��Ϣ >> %output%
powershell -c "(Invoke-WebRequest -Uri https://api.ipify.org -UseBasicParsing).Content" >> %output%
echo ���ü�� >> %output%
powershell -c "(Invoke-WebRequest -Uri https://ifconfig.me/ip -UseBasicParsing).Content" >> %output%

echo. >> %output% & echo �� ������ͨ�Բ��� >> %output%
ping 223.5.5.5 -n 4 >> %output%
ping www.baidu.com -n 4 >> %output%

echo. >> %output% & echo �� ·��׷�ٲ��� >> %output%
tracert -d 114.114.114.114 >> %output%

echo. >> %output% & echo �� ARP����� >> %output%
arp -a >> %output%

echo. >> %output% & echo �� ��������� >> %output%
netstat -ano -p tcp | findstr "ESTABLISHED" >> %output%

echo. >> %output% & echo �� ���ط���˿ڼ��� >> %output%
netstat -ano | findstr "LISTENING" >> %output%

REM ======================
REM ������ɨ��
REM ======================
echo. >> %output% & echo. >> %output% & echo ====== [������ɨ��] ====== >> %output%

echo �� ��ǰ�����豸ɨ�� >> %output%
set gateway=
for /f "tokens=1-3 delims=: " %%a in ('ipconfig ^| findstr "Ĭ������"') do set gateway=%%c
echo Ĭ������: %gateway% >> %output%

if defined gateway (
   echo ����ɨ��%gateway:~0,-3%.0/24����... >> %output%
   for /L %%i in (1,1,254) do (
      ping -n 1 -w 100 %gateway:~0,-3%.%%i | findstr "TTL=" >nul && echo �����: %gateway:~0,-3%.%%i >> %output%
   )
)

echo. >> %output% & echo �� ���繲����Դ >> %output%
net view >> %output%

echo. >> %output% & echo �� SMB�Ự��Ϣ >> %output%
net session >> %output%

REM ======================
REM ���մ���
REM ======================
echo ����������ɣ� >> %output%
echo �ļ�λ��: %output%

timeout /t 5 >nul
start notepad %output%
exit