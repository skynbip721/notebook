@echo off
setlocal enabledelayedexpansion

:: ���ÿ���̨���ڱ���
title YouTube��Ƶ���ع��� (yt-dlp)

:: ���yt-dlp�Ƿ�װ
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: δ�ҵ�yt-dlp�����Ȱ�װyt-dlp
    echo ���Դ� https://github.com/yt-dlp/yt-dlp ����
    pause
    exit /b
)

:: ���˵�
:menu
cls
echo ****************************************
echo      YouTube��Ƶ�������ع��� (yt-dlp)
echo ****************************************
echo.
echo 1. ������ƵURL�б�����
echo 2. ���뵥����ƵURL����
echo 3. ���ı���λ�� (��ǰ: %savepath%)
echo 4. �������ظ�ʽ������
echo 5. �˳�
echo.
set /p choice=��ѡ����� [1-5]:

if "%choice%"=="1" goto batch_download
if "%choice%"=="2" goto single_download
if "%choice%"=="3" goto set_path
if "%choice%"=="4" goto set_format
if "%choice%"=="5" exit

echo ��Чѡ������������
pause
goto menu

:: ��������
:batch_download
cls
echo ��������ģʽ (��������URL��ÿ��һ��)
echo ��ɺ������µ�һ������"end"���س�
echo.
echo ��ǰ����λ��: %savepath%
echo.

set "inputfile=%temp%\yt_urls.txt"
echo ��������ƵURL�б�: > "%inputfile%"
notepad "%inputfile%"

if not exist "%inputfile%" (
    echo ����: δ����URL�б��ļ�
    pause
    goto menu
)

:: ����ļ��Ƿ�Ϊ�ջ�ֻ����"end"
set "empty=1"
for /f "usebackq delims=" %%a in ("%inputfile%") do (
    if not "%%a"=="end" set "empty=0"
)

if "%empty%"=="1" (
    echo ����: URL�б�Ϊ��
    del "%inputfile%"
    pause
    goto menu
)

echo.
echo ��ʼ�����б��е���Ƶ...
echo.

for /f "usebackq delims=" %%a in ("%inputfile%") do (
    if not "%%a"=="end" (
        echo ��������: %%a
        yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %format% "%%a"
        echo.
    )
)

del "%inputfile%"
echo �����������!
pause
goto menu

:: ��������
:single_download
cls
echo ������Ƶ����ģʽ
echo ��ǰ����λ��: %savepath%
echo.
set /p url=��������ƵURL: 

if "%url%"=="" (
    echo ����: URL����Ϊ��
    pause
    goto single_download
)

echo.
echo ��ʼ������Ƶ...
yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %format% "%url%"

echo.
echo �������!
pause
goto menu

:: ���ñ���·��
:set_path
cls
echo ��ǰ����λ��: %savepath%
echo.
echo �������µı���·�� (����: D:\Videos �� C:\Users\�������\Downloads)
echo ע��: ·���в�Ҫ��������
echo.
set /p savepath=�±���·��: 

:: ����û�û�����룬����ԭ·��
if "%savepath%"=="" (
    set savepath=%cd%
    echo ����ԭ·��: %savepath%
) else (
    :: ����Ŀ¼���������
    if not exist "%savepath%" (
        mkdir "%savepath%"
    )
    echo ����·���Ѹ���: %savepath%
)

pause
goto menu

:: �������ظ�ʽ������
:set_format
cls
echo ��ǰ��������: %format%
echo.
echo ��ѡ�����ظ�ʽ������:
echo 1. ������� (Ĭ��)
echo 2. ����Ƶ (MP3)
echo 3. 720p��Ƶ
echo 4. 1080p��Ƶ
echo 5. �Զ����ʽ
echo 6. �������˵�
echo.
set /p fmt_choice=��ѡ�� [1-6]: 

if "%fmt_choice%"=="1" set "format=" & goto format_set
if "%fmt_choice%"=="2" set "format=-x --audio-format mp3" & goto format_set
if "%fmt_choice%"=="3" set "format=-f "bestvideo[height<=720]+bestaudio/best[height<=720]"" & goto format_set
if "%fmt_choice%"=="4" set "format=-f "bestvideo[height<=1080]+bestaudio/best[height<=1080]"" & goto format_set
if "%fmt_choice%"=="5" goto custom_format
if "%fmt_choice%"=="6" goto menu

echo ��Чѡ��
pause
goto set_format

:custom_format
cls
echo ��ǰ��������: %format%
echo.
echo �������Զ���yt-dlp��ʽ����:
echo ����: -f "bestvideo[height<=720]+bestaudio/best[height<=720]"
echo ��: -x --audio-format mp3
echo ������ָ�Ĭ������
echo.
set /p format=�Զ����ʽ����: 

if "%format%"=="" (
    set "format="
    echo �ѻָ�Ĭ������
) else (
    echo �Զ����ʽ������: %format%
)

pause
goto menu

:format_set
echo ���ظ�ʽ�Ѹ���: %format%
pause
goto menu

:: ��ʼ������
if not defined savepath set "savepath=%cd%"
if not defined format set "format="