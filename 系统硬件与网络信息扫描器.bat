@echo off
color 1F
title ϵͳ��Ϣɨ����

echo.
echo ================================================
echo        ϵͳӲ����������Ϣɨ����
echo ================================================
echo.

:: Ӳ����Ϣ����
echo [1/4] ���ڻ�ȡӲ����Ϣ...
echo.

:: ����ϵͳ��Ϣ
echo ����ϵͳ��Ϣ:
systeminfo | findstr /B /C:"OS ����" /C:"OS �汾" /C:"ϵͳ������" /C:"ϵͳ����"
echo.

:: CPU��Ϣ
echo ��������Ϣ:
wmic cpu get name,NumberOfCores,NumberOfLogicalProcessors /format:table | findstr /V "Name"
echo.

:: �ڴ���Ϣ
echo �����ڴ���Ϣ:
wmic memorychip get Capacity,MemoryType,Speed /format:table | findstr /V "Capacity"
echo.

:: Ӳ����Ϣ
echo ������Ϣ:
wmic diskdrive get size,model,serialnumber /format:table | findstr /V "Size"
echo.

:: ������Ϣ
echo ������Ϣ:
wmic baseboard get product,manufacturer,version,serialnumber /format:table | findstr /V "Product"
echo.

:: ������Ϣ����
echo [2/4] ���ڻ�ȡ������Ϣ...
echo.

:: IP����
echo IP��ַ��Ϣ:
ipconfig | findstr /V "IPv6" | findstr /V "ý��״̬"
echo.

:: MAC��ַ
echo ����������MAC��ַ:
getmac /v | findstr /V "MAC Address"
echo.

:: ���غ�DNS
echo ���غ�DNS��Ϣ:
ipconfig /all | findstr /C:"Ĭ������" /C:"DNS ������"
echo.

:: ��������״̬
echo ��������״̬:
netsh wlan show profiles
echo.

:: ϵͳ��Ϣ����
echo [3/4] ����ϵͳ��Ϣ...
echo.

:: ��������
echo ϵͳ����·��:
echo %PATH% | more
echo.

:: ������Ϣ
echo �Ѱ�װ����:
wmic qfe list brief /format:table | findstr /V "HotFixID"
echo.

:: ϵͳ����ʱ��
echo ϵͳ����ʱ��:
systeminfo | find "ϵͳ����ʱ��"
echo.

:: ������Բ���
echo [4/4] ����ִ���������...
echo.

:: Ping����
echo ���ڲ�����������...
ping -n 3 www.baidu.com > nul
if errorlevel 1 (
    echo �������Ӳ���ʧ�ܣ�������������
) else (
    echo ������������
)
echo.

:: Traceroute
echo ����ִ��·��׷��...
tracert -d www.baidu.com | findstr /V "����·��"
echo.

pause
exit