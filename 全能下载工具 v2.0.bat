@echo off
setlocal enabledelayedexpansion

:: 设置控制台窗口标题
title 全能下载工具 v2.0

:: 初始化变量
if not defined savepath set "savepath=%USERPROFILE%\Downloads"
if not exist "%savepath%" mkdir "%savepath%"

:: 主菜单
:main_menu
cls
echo ========================================
echo           全能下载工具 v2.0
echo ========================================
echo.
echo 当前下载目录: %savepath%
echo.
echo 1. HTTP/FTP/HTTPS下载
echo 2. 磁力链接下载
echo 3. BT种子下载
echo 4. 电驴链接下载
echo 5. 视频网站下载(YouTube/B站等)
echo 6. 音频提取(MP3/FLAC等)
echo 7. 更改保存位置
echo 8. 查看下载任务
echo 9. 退出
echo.
set /p choice=请选择操作 [1-9]: 

if "%choice%"=="1" goto http_download
if "%choice%"=="2" goto magnet_download
if "%choice%"=="3" goto torrent_download
if "%choice%"=="4" goto ed2k_download
if "%choice%"=="5" goto video_download
if "%choice%"=="6" goto audio_download
if "%choice%"=="7" goto set_path
if "%choice%"=="8" goto view_tasks
if "%choice%"=="9" exit /b

echo 无效选择，请重新输入
pause
goto main_menu

:: HTTP/FTP下载
:http_download
cls
echo HTTP/FTP/HTTPS下载模式
echo 当前保存位置: %savepath%
echo.
echo 支持: 直链、迅雷链接、Flashget链接等
echo.
set /p url=请输入下载链接: 

if "%url%"=="" (
    echo 错误: 链接不能为空
    pause
    goto http_download
)

:: 检查是否安装了aria2c或curl
where aria2c >nul 2>&1
if %errorlevel% equ 0 (
    echo.
    echo 使用aria2c多线程下载...
    aria2c -d "%savepath%" -x 16 -s 16 -k 1M --file-allocation=none "%url%"
) else (
    where curl >nul 2>&1
    if %errorlevel% equ 0 (
        echo.
        echo 使用curl下载...
        curl -L -o "%savepath%\%~nx1" "%url%"
    ) else (
        echo.
        echo 错误: 未找到aria2c或curl下载工具
        echo 请安装aria2c或curl
    )
)

echo.
echo 下载完成!
pause
goto main_menu

:: 磁力链接下载
:magnet_download
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 需要aria2c来下载磁力链接
    echo 请从 https://aria2.github.io 安装
    pause
    goto main_menu
)

cls
echo 磁力链接下载模式
echo 当前保存位置: %savepath%
echo.
set /p magnet=请输入磁力链接(magnet:?xt=urn:btih:): 

if "%magnet%"=="" (
    echo 错误: 磁力链接不能为空
    pause
    goto magnet_download
)

echo.
echo 开始下载...
aria2c -d "%savepath%" --seed-time=0 --bt-enable-lpd=true --bt-max-peers=50 "%magnet%"

echo.
echo 下载任务已启动!
pause
goto main_menu

:: BT种子下载
:torrent_download
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 需要aria2c来下载BT种子
    echo 请从 https://aria2.github.io 安装
    pause
    goto main_menu
)

cls
echo BT种子下载模式
echo 当前保存位置: %savepath%
echo.
echo 请将种子文件拖放到此窗口，然后按回车
set /p torrent=种子文件路径: 

if "%torrent%"=="" (
    echo 错误: 必须指定种子文件
    pause
    goto torrent_download
)

echo.
echo 开始下载...
aria2c -d "%savepath%" --seed-time=0 --bt-enable-lpd=true --bt-max-peers=50 "%torrent%"

echo.
echo 下载任务已启动!
pause
goto main_menu

:: 电驴下载
:ed2k_download
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 需要aria2c来下载电驴链接
    echo 请从 https://aria2.github.io 安装
    pause
    goto main_menu
)

cls
echo 电驴链接下载模式
echo 当前保存位置: %savepath%
echo.
set /p ed2k=请输入电驴链接(ed2k://): 

if "%ed2k%"=="" (
    echo 错误: 电驴链接不能为空
    pause
    goto ed2k_download
)

echo.
echo 开始下载...
aria2c -d "%savepath%" "%ed2k%"

echo.
echo 下载任务已启动!
pause
goto main_menu

:: 视频下载
:video_download
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 需要yt-dlp来下载视频
    echo 请从 https://github.com/yt-dlp/yt-dlp 安装
    pause
    goto main_menu
)

cls
echo 视频网站下载模式
echo 当前保存位置: %savepath%
echo.
echo 支持: YouTube, B站, 抖音等1000+网站
echo.
echo 1. 下载最佳质量
echo 2. 选择分辨率
echo 3. 仅下载音频
echo 4. 返回主菜单
echo.
set /p video_choice=请选择: 

if "%video_choice%"=="1" (
    set "video_args=-f bestvideo+bestaudio/best"
) else if "%video_choice%"=="2" (
    goto select_resolution
) else if "%video_choice%"=="3" (
    set "video_args=-x --audio-format mp3"
) else if "%video_choice%"=="4" (
    goto main_menu
) else (
    echo 无效选择
    pause
    goto video_download
)

:get_video_url
cls
set /p video_url=请输入视频URL: 

if "%video_url%"=="" (
    echo 错误: URL不能为空
    pause
    goto get_video_url
)

echo.
echo 开始下载...
yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %video_args% "%video_url%"

echo.
echo 下载完成!
set "video_args="
pause
goto main_menu

:select_resolution
cls
echo 请选择视频分辨率:
echo.
echo 1. 8K (4320p)
echo 2. 4K (2160p)
echo 3. 1080p
echo 4. 720p
echo 5. 480p
echo 6. 自定义分辨率
echo 7. 返回
echo.
set /p res_choice=请选择: 

if "%res_choice%"=="1" set "video_args=-f "bestvideo[height<=4320]+bestaudio/best[height<=4320]""
if "%res_choice%"=="2" set "video_args=-f "bestvideo[height<=2160]+bestaudio/best[height<=2160]""
if "%res_choice%"=="3" set "video_args=-f "bestvideo[height<=1080]+bestaudio/best[height<=1080]""
if "%res_choice%"=="4" set "video_args=-f "bestvideo[height<=720]+bestaudio/best[height<=720]""
if "%res_choice%"=="5" set "video_args=-f "bestvideo[height<=480]+bestaudio/best[height<=480]""
if "%res_choice%"=="6" goto custom_resolution
if "%res_choice%"=="7" goto video_download

if not defined video_args (
    echo 无效选择
    pause
    goto select_resolution
)

goto get_video_url

:custom_resolution
cls
set /p custom_height=请输入最大分辨率高度(例如720): 
if "%custom_height%"=="" (
    echo 错误: 必须输入分辨率
    pause
    goto custom_resolution
)

set "video_args=-f "bestvideo[height<=%custom_height%]+bestaudio/best[height<=%custom_height%]""
goto get_video_url

:: 音频下载
:audio_download
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 需要yt-dlp来提取音频
    echo 请从 https://github.com/yt-dlp/yt-dlp 安装
    pause
    goto main_menu
)

cls
echo 音频提取模式
echo 当前保存位置: %savepath%
echo.
echo 1. MP3格式(标准质量)
echo 2. MP3格式(高质量)
echo 3. FLAC格式(无损)
echo 4. 返回主菜单
echo.
set /p audio_choice=请选择: 

if "%audio_choice%"=="1" set "audio_args=-x --audio-format mp3 --audio-quality 5"
if "%audio_choice%"=="2" set "audio_args=-x --audio-format mp3 --audio-quality 0"
if "%audio_choice%"=="3" set "audio_args=-x --audio-format flac"
if "%audio_choice%"=="4" goto main_menu

if not defined audio_args (
    echo 无效选择
    pause
    goto audio_download
)

cls
set /p audio_url=请输入视频/音频URL: 

if "%audio_url%"=="" (
    echo 错误: URL不能为空
    pause
    goto audio_download
)

echo.
echo 开始提取音频...
yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %audio_args% "%audio_url%"

echo.
echo 音频提取完成!
set "audio_args="
pause
goto main_menu

:: 设置保存路径
:set_path
cls
echo 当前保存位置: %savepath%
echo.
echo 请输入新的保存路径 (例如: D:\Downloads)
echo 注意: 路径中不要包含引号
echo.
set /p new_path=新保存路径: 

if "%new_path%"=="" (
    echo 保存路径未更改
) else (
    if not exist "%new_path%" (
        mkdir "%new_path%"
    )
    set "savepath=%new_path%"
    echo 保存路径已更新: %savepath%
)

pause
goto main_menu

:: 查看下载任务
:view_tasks
where aria2c >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 需要aria2c来查看下载任务
    pause
    goto main_menu
)

cls
echo 当前下载任务 (aria2c):
echo.
aria2c tellStatus
echo.
pause
goto main_menu