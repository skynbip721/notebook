@echo off
setlocal enabledelayedexpansion
title ������Ϣ��ѯ����
color 0A

:: ��������ļ�·��
set "outputFile=%USERPROFILE%\Desktop\������Ϣ.txt"
echo ===== ϵͳ������Ϣ ===== > "%outputFile%"
echo ����ʱ��: %date% %time% >> "%outputFile%"
echo ======================== >> "%outputFile%"

:: һ������ϵͳ��Ϣ
echo [1](@ref)ϵͳ������Ϣ >> "%outputFile%"
systeminfo | findstr /C:"OS ����" /C:"OS �汾" /C:"ϵͳ������" /C:"ϵͳ�ͺ�" >> "%outputFile%"
echo. >> "%outputFile%"

:: ����Ӳ����ϸ��Ϣ
echo [2](@ref)Ӳ��������Ϣ >> "%outputFile%"
echo ------------------------ >> "%outputFile%"
echo ������Ϣ: >> "%outputFile%"
wmic baseboard get manufacturer,product,version,serialnumber >> "%outputFile%"
echo. >> "%outputFile%"

echo CPU��Ϣ: >> "%outputFile%"
wmic cpu get name,numberofcores,numberoflogicalprocessors,maxclockspeed >> "%outputFile%"
echo. >> "%outputFile%"

echo �ڴ���Ϣ: >> "%outputFile%"
wmic memorychip get manufacturer,partnumber,capacity,serialnumber >> "%outputFile%"
echo. >> "%outputFile%"

echo Ӳ����Ϣ: >> "%outputFile%"
wmic diskdrive get model,size,serialnumber >> "%outputFile%"
echo. >> "%outputFile%"

echo �Կ���Ϣ: >> "%outputFile%"
wmic path win32_videocontroller get name,adapterram >> "%outputFile%"
echo. >> "%outputFile%"

:: �������������Ϣ
echo [3](@ref)����������Ϣ >> "%outputFile%"
echo ==================== >> "%outputFile%"

echo ��ǰIP����: >> "%outputFile%"
ipconfig | findstr /C:"IPv4 ��ַ" /C:"��������" /C:"Ĭ������" >> "%outputFile%"

echo DNS����������: >> "%outputFile%"
ipconfig /all | findstr /C:"DNS ������" >> "%outputFile%"

echo ����������Ϣ: >> "%outputFile%"
getmac /v | findstr /C:"�����ַ" /C:"��������" >> "%outputFile%"

:: �ġ�������ͨ�Լ��
echo [4](@ref)������ͨ�Բ��� >> "%outputFile%"
echo ================== >> "%outputFile%"
echo ����������ͨ��: >> "%outputFile%"
ping www.baidu.com -n 3 | findstr "ʱ��=" >> "%outputFile%"
echo. >> "%outputFile%"

echo ·��׷�ٲ���: >> "%outputFile%"
tracert www.baidu.com | findstr "1" >> "%outputFile%"
echo. >> "%outputFile%"

:: ������ʱ�ļ�
del /f "%TEMP%\*.tmp" 2>nul

echo ��Ϣ�ռ���ɣ���������˳�...
pause >nul
exit