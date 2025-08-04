@echo off
setlocal enabledelayedexpansion

:: ���ÿ���̨���ڱ���
title ȫ�����ع��� v2.0

:: ��ʼ������
if not defined savepath set "savepath=%USERPROFILE%\Downloads"
if not exist "%savepath%" mkdir "%savepath%"

:: ���˵�
:main_menu
cls
echo ========================================
echo           ȫ�����ع��� v2.0
echo ========================================
echo.
echo ��ǰ����Ŀ¼: %savepath%
echo.
echo 1. HTTP/FTP/HTTPS����
echo 2. ������������
echo 3. BT��������
echo 4. ��¿��������
echo 5. ��Ƶ��վ����(YouTube/Bվ��)
echo 6. ��Ƶ��ȡ(MP3/FLAC��)
echo 7. ���ı���λ��
echo 8. �鿴��������
echo 9. �˳�
echo.
set /p choice=��ѡ����� [1-9]: 

if "%choice%"=="1" goto http_download
if "%choice%"=="2" goto magnet_download
if "%choice%"=="3" goto torrent_download
if "%choice%"=="4" goto ed2k_download
if "%choice%"=="5" goto video_download
if "%choice%"=="6" goto audio_download
if "%choice%"=="7" goto set_path
if "%choice%"=="8" goto view_tasks
if "%choice%"=="9" exit /b

echo ��Чѡ������������
pause
goto main_menu

:: HTTP/FTP����
:http_download
cls
echo HTTP/FTP/HTTPS����ģʽ
echo ��ǰ����λ��: %savepath%
echo.
echo ֧��: ֱ����Ѹ�����ӡ�Flashget���ӵ�
echo.
set /p url=��������������: 

if "%url%"=="" (
    echo ����: ���Ӳ���Ϊ��
    pause
    goto http_download
)

:: ����Ƿ�װ��aria2c��curl
where aria2c >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo ʹ��aria2c���߳�����...
    aria2c -d "%savepath%" -x 16 -s 16 -k 1M --file-allocation=none "%url%"
) else (
    where curl >nul 2>&1
    if %errorlevel% equ 0 (
        echo.
        echo ʹ��curl����...
        curl -L -o "%savepath%\%~nx1" "%url%"
    ) else (
        echo.
        echo ����: δ�ҵ�aria2c��curl���ع���
        echo �밲װaria2c��curl
    )
)

echo.
echo �������!
pause
goto main_menu

:: ������������
:magnet_download
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: ��Ҫaria2c�����ش�������
    echo ��� https://aria2.github.io ��װ
    pause
    goto main_menu
)

cls
echo ������������ģʽ
echo ��ǰ����λ��: %savepath%
echo.
set /p magnet=�������������(magnet:?xt=urn:btih:): 

if "%magnet%"=="" (
    echo ����: �������Ӳ���Ϊ��
    pause
    goto magnet_download
)

echo.
echo ��ʼ����...
aria2c -d "%savepath%" --seed-time=0 --bt-enable-lpd=true --bt-max-peers=50 "%magnet%"

echo.
echo ��������������!
pause
goto main_menu

:: BT��������
:torrent_download
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: ��Ҫaria2c������BT����
    echo ��� https://aria2.github.io ��װ
    pause
    goto main_menu
)

cls
echo BT��������ģʽ
echo ��ǰ����λ��: %savepath%
echo.
echo �뽫�����ļ��Ϸŵ��˴��ڣ�Ȼ�󰴻س�
set /p torrent=�����ļ�·��: 

if "%torrent%"=="" (
    echo ����: ����ָ�������ļ�
    pause
    goto torrent_download
)

echo.
echo ��ʼ����...
aria2c -d "%savepath%" --seed-time=0 --bt-enable-lpd=true --bt-max-peers=50 "%torrent%"

echo.
echo ��������������!
pause
goto main_menu

:: ��¿����
:ed2k_download
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: ��Ҫaria2c�����ص�¿����
    echo ��� https://aria2.github.io ��װ
    pause
    goto main_menu
)

cls
echo ��¿��������ģʽ
echo ��ǰ����λ��: %savepath%
echo.
set /p ed2k=�������¿����(ed2k://): 

if "%ed2k%"=="" (
    echo ����: ��¿���Ӳ���Ϊ��
    pause
    goto ed2k_download
)

echo.
echo ��ʼ����...
aria2c -d "%savepath%" "%ed2k%"

echo.
echo ��������������!
pause
goto main_menu

:: ��Ƶ����
:video_download
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: ��Ҫyt-dlp��������Ƶ
    echo ��� https://github.com/yt-dlp/yt-dlp ��װ
    pause
    goto main_menu
)

cls
echo ��Ƶ��վ����ģʽ
echo ��ǰ����λ��: %savepath%
echo.
echo ֧��: YouTube, Bվ, ������1000+��վ
echo.
echo 1. �����������
echo 2. ѡ��ֱ���
echo 3. ��������Ƶ
echo 4. �������˵�
echo.
set /p video_choice=��ѡ��: 

if "%video_choice%"=="1" (
    set "video_args=-f bestvideo+bestaudio/best"
) else if "%video_choice%"=="2" (
    goto select_resolution
) else if "%video_choice%"=="3" (
    set "video_args=-x --audio-format mp3"
) else if "%video_choice%"=="4" (
    goto main_menu
) else (
    echo ��Чѡ��
    pause
    goto video_download
)

:get_video_url
cls
set /p video_url=��������ƵURL: 

if "%video_url%"=="" (
    echo ����: URL����Ϊ��
    pause
    goto get_video_url
)

echo.
echo ��ʼ����...
yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %video_args% "%video_url%"

echo.
echo �������!
set "video_args="
pause
goto main_menu

:select_resolution
cls
echo ��ѡ����Ƶ�ֱ���:
echo.
echo 1. 8K (4320p)
echo 2. 4K (2160p)
echo 3. 1080p
echo 4. 720p
echo 5. 480p
echo 6. �Զ���ֱ���
echo 7. ����
echo.
set /p res_choice=��ѡ��: 

if "%res_choice%"=="1" set "video_args=-f "bestvideo[height<=4320]+bestaudio/best[height<=4320]""
if "%res_choice%"=="2" set "video_args=-f "bestvideo[height<=2160]+bestaudio/best[height<=2160]""
if "%res_choice%"=="3" set "video_args=-f "bestvideo[height<=1080]+bestaudio/best[height<=1080]""
if "%res_choice%"=="4" set "video_args=-f "bestvideo[height<=720]+bestaudio/best[height<=720]""
if "%res_choice%"=="5" set "video_args=-f "bestvideo[height<=480]+bestaudio/best[height<=480]""
if "%res_choice%"=="6" goto custom_resolution
if "%res_choice%"=="7" goto video_download

if not defined video_args (
    echo ��Чѡ��
    pause
    goto select_resolution
)

goto get_video_url

:custom_resolution
cls
set /p custom_height=���������ֱ��ʸ߶�(����720): 
if "%custom_height%"=="" (
    echo ����: ��������ֱ���
    pause
    goto custom_resolution
)

set "video_args=-f "bestvideo[height<=%custom_height%]+bestaudio/best[height<=%custom_height%]""
goto get_video_url

:: ��Ƶ����
:audio_download
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: ��Ҫyt-dlp����ȡ��Ƶ
    echo ��� https://github.com/yt-dlp/yt-dlp ��װ
    pause
    goto main_menu
)

cls
echo ��Ƶ��ȡģʽ
echo ��ǰ����λ��: %savepath%
echo.
echo 1. MP3��ʽ(��׼����)
echo 2. MP3��ʽ(������)
echo 3. FLAC��ʽ(����)
echo 4. �������˵�
echo.
set /p audio_choice=��ѡ��: 

if "%audio_choice%"=="1" set "audio_args=-x --audio-format mp3 --audio-quality 5"
if "%audio_choice%"=="2" set "audio_args=-x --audio-format mp3 --audio-quality 0"
if "%audio_choice%"=="3" set "audio_args=-x --audio-format flac"
if "%audio_choice%"=="4" goto main_menu

if not defined audio_args (
    echo ��Чѡ��
    pause
    goto audio_download
)

cls
set /p audio_url=��������Ƶ/��ƵURL: 

if "%audio_url%"=="" (
    echo ����: URL����Ϊ��
    pause
    goto audio_download
)

echo.
echo ��ʼ��ȡ��Ƶ...
yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %audio_args% "%audio_url%"

echo.
echo ��Ƶ��ȡ���!
set "audio_args="
pause
goto main_menu

:: ���ñ���·��
:set_path
cls
echo ��ǰ����λ��: %savepath%
echo.
echo �������µı���·�� (����: D:\Downloads)
echo ע��: ·���в�Ҫ��������
echo.
set /p new_path=�±���·��: 

if "%new_path%"=="" (
    echo ����·��δ����
) else (
    if not exist "%new_path%" (
        mkdir "%new_path%"
    )
    set "savepath=%new_path%"
    echo ����·���Ѹ���: %savepath%
)

pause
goto main_menu

:: �鿴��������
:view_tasks
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo ����: ��Ҫaria2c���鿴��������
    pause
    goto main_menu
)

cls
echo ��ǰ�������� (aria2c):
echo.
aria2c tellStatus
echo.
pause
goto main_menu