@echo off
setlocal enabledelayedexpansion

:: ==============================================
:: ��������
set "DOWNLOAD_PATH=%USERPROFILE%\Desktop\VideoDownloads"
set "YTDLP_ARGS=-f bestvideo+bestaudio/best --merge-output-format mp4 --console-title"

:: ==============================================
:: ���������
where yt-dlp >nul 2>&1 || (
    echo ����: ���Ȱ�װ yt-dlp
    echo �ٷ���ַ: https://github.com/yt-dlp/yt-dlp
    timeout /t 5
    exit /b 1
)

where ffmpeg >nul 2>&1 || (
    echo ����: ���Ȱ�װ FFmpeg
    echo �ٷ���ַ: https://ffmpeg.org/
    timeout /t 5
    exit /b 1
)

:: ��������Ŀ¼
if not exist "%DOWNLOAD_PATH%" (
    mkdir "%DOWNLOAD_PATH%"
    echo �Ѵ�������Ŀ¼: %DOWNLOAD_PATH%
)

:: ==============================================
:start
cls
echo �Ϸ�ʹ��������
echo 1. ��ȷ����ӵ���������ݵĺϷ�Ȩ��
echo 2. ��ֹ�����ܰ�Ȩ�����ĸ�������
echo 3. ���ű������ڼ����о�Ŀ��
echo ====================================

echo.
set /p "input_url=��������ƵURL������ exit �˳���: "

if "%input_url%" == "exit" exit /b

:: ִ����������
echo �������ص�: %DOWNLOAD_PATH%
yt-dlp %YTDLP_ARGS% -o "%DOWNLOAD_PATH%\%%(title)s.%%(ext)s" "%input_url%"

if errorlevel 1 (
    echo ����ʧ�ܣ����飺
    echo 1. URL��Ч��
    echo 2. ��������
    echo 3. ƽ̨����
    pause
)

goto start