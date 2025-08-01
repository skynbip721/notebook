@echo off
setlocal enabledelayedexpansion

:: ==============================================
:: 下载配置
set "DOWNLOAD_PATH=%USERPROFILE%\Desktop\VideoDownloads"
set "YTDLP_ARGS=-f bestvideo+bestaudio/best --merge-output-format mp4 --console-title"

:: ==============================================
:: 检查依赖项
where yt-dlp >nul 2>&1 || (
    echo 错误: 请先安装 yt-dlp
    echo 官方地址: https://github.com/yt-dlp/yt-dlp
    timeout /t 5
    exit /b 1
)

where ffmpeg >nul 2>&1 || (
    echo 错误: 请先安装 FFmpeg
    echo 官方地址: https://ffmpeg.org/
    timeout /t 5
    exit /b 1
)

:: 创建下载目录
if not exist "%DOWNLOAD_PATH%" (
    mkdir "%DOWNLOAD_PATH%"
    echo 已创建下载目录: %DOWNLOAD_PATH%
)

:: ==============================================
:start
cls
echo 合法使用声明：
echo 1. 请确保您拥有下载内容的合法权限
echo 2. 禁止下载受版权保护的付费内容
echo 3. 本脚本仅用于技术研究目的
echo ====================================

echo.
set /p "input_url=请输入视频URL（输入 exit 退出）: "

if "%input_url%" == "exit" exit /b

:: 执行下载命令
echo 正在下载到: %DOWNLOAD_PATH%
yt-dlp %YTDLP_ARGS% -o "%DOWNLOAD_PATH%\%%(title)s.%%(ext)s" "%input_url%"

if errorlevel 1 (
    echo 下载失败，请检查：
    echo 1. URL有效性
    echo 2. 网络连接
    echo 3. 平台限制
    pause
)

goto start