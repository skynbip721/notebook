@echo off
setlocal enabledelayedexpansion

REM ������ԱȨ��
NET SESSION >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo ���Թ���Ա������д˽ű���
    pause
    exit /b
)

REM ��������ļ�·��
set "output=%USERPROFILE%\Desktop\System_Info.txt"

echo �����ռ�ϵͳ��Ϣ�����Ժ�...
echo �������Ҫ������ʱ��...

REM ϵͳ������Ϣ
echo ====== ϵͳժҪ��Ϣ ====== > %output%
systeminfo >> %output%

REM ��ϸ��Ӳ����Ϣ
echo. >> %output% & echo. >> %output%
echo ====== ��������Ϣ ====== >> %output%
wmic cpu get Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed,Status /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== �ڴ���Ϣ ====== >> %output%
wmic memorychip get Capacity,PartNumber,Speed,Manufacturer,FormFactor /format:list >> %output%
wmic ComputerSystem get TotalPhysicalMemory /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ������Ϣ ====== >> %output%
wmic baseboard get Product,Manufacturer,Version,SerialNumber /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== BIOS ��Ϣ ====== >> %output%
wmic bios get Name,Version,Manufacturer,ReleaseDate,SerialNumber /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ������Ϣ ====== >> %output%
wmic diskdrive get Model,Size,InterfaceType,MediaType,SerialNumber /format:list >> %output%
echo. >> %output%
wmic logicaldisk where DriveType=3 get DeviceID,Size,FreeSpace /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== �Կ���Ϣ ====== >> %output%
wmic path Win32_VideoController get Name,AdapterRAM,DriverVersion /format:list >> %output%

REM ������Ϣ
echo. >> %output% & echo. >> %output%
echo ====== ������������Ϣ ====== >> %output%
wmic nicconfig where "IPEnabled=true" get MACAddress,IPAddress,DNSHostName,DefaultIPGateway,DNSServerSearchOrder /format:list >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ��ϸ�������� ====== >> %output%
ipconfig /all >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ·�ɱ� ====== >> %output%
route print >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ARP���� ====== >> %output%
arp -a >> %output%

echo. >> %output% & echo. >> %output%
echo ====== ��������״̬ ====== >> %output%
netstat -ano >> %output%

REM ����������Ϣ
echo. >> %output% & echo. >> %output%
echo ====== �Ѱ�װ�������� ====== >> %output%
driverquery /v >> %output%

echo ��Ϣ�ռ���ɣ�
echo �����ѱ��浽���棺%output%
pause