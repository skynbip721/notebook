@echo off
setlocal enabledelayedexpansion
color 0a
title ������Ϲ����� v1.0

:MAIN
cls
echo.
echo  ������Ϲ�����
echo  ========================
echo  1. ��ʾIP��Ϣ
echo  2. ������ͨ�Բ���
echo  3. WebRTC���
echo  4. DNSй©����
echo  5. ���ٲ���
echo  6. �߼�����
echo  7. �˳�
echo  ========================
set /p choice=��ѡ���� [1-7]: 

goto MENU%choice%

:MENU1
cls
echo ���ڻ�ȡ������Ϣ...
echo ========================
echo ������������Ϣ��
ipconfig | findstr /i "IPv4 �������� Ĭ������"
echo.

echo ������IP��Ϣ��
curl -s https://api.ipify.org
echo.
echo ========================
pause
goto MAIN

:MENU2
cls
echo ����ִ��������ͨ�Բ���...
echo ========================
echo ����������ͨ��...
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr "Ĭ������"') do ping %%i -n 4

echo.
echo ���Ի�������ͨ��...
ping 8.8.8.8 -n 4 | findstr "ͳ����Ϣ"
ping 114.114.114.114 -n 4 | findstr "ͳ����Ϣ"
ping www.baidu.com -n 4 | findstr "ͳ����Ϣ"
echo ========================
pause
goto MAIN

:MENU3
cls
echo ����׼��WebRTC���...
echo ========================
echo ��ʹ��������������µ�ַ���в��ԣ�
echo https://webrtc-test.net
echo.
start https://webrtc-test.net
pause
goto MAIN

:MENU4
cls
echo ����׼��DNSй©����...
echo ========================
echo ��ʹ��������������µ�ַ��
echo https://www.dnsleaktest.com
echo.
start https://www.dnsleaktest.com
pause
goto MAIN

:MENU5
cls
echo ��ѡ����ٷ�ʽ��
echo 1) ��ҳ��Speedtest
echo 2) �����в��٣��谲װspeedtest-cli��
set /p speed=ѡ��[1-2]: 

if %speed%==1 (
    start https://www.speedtest.net/
) else if %speed%==2 (
    echo ���ڲ��������ٶ�...
    speedtest-cli --simple
)
pause
goto MAIN

:MENU6
cls
echo �߼�����
echo ========================
echo 1) ·�ɸ���
echo 2) DNS��ѯ
echo 3) �˿�ɨ��
echo 4) �������˵�
set /p adv=��ѡ�񹤾�[1-4]: 

if %adv%==1 (
    set /p target=���������Ŀ��: 
    tracert !target!
    pause
    goto MENU6
)

if %adv%==2 (
    set /p domain=�������ѯ����: 
    nslookup !domain! 8.8.8.8
    nslookup !domain! 114.114.114.114
    pause
    goto MENU6
)

if %adv%==3 (
    set /p target=������ɨ��Ŀ��: 
    set /p ports=������˿ڷ�Χ(�� 80-100): 
    echo ����ɨ��!target! �˿�!ports!...
    powershell -command "$target='!target!'; $ports=!ports! -split '-'; foreach ($port in $ports[0]..$ports[1]) {Test-NetConnection $target -Port $port | Where-Object {$_.TcpTestSucceeded}}"
    pause
    goto MENU6
)

goto MAIN

:MENU7
exit

:ERROR
echo ��Ч���룬������ѡ��!
pause
goto MAIN