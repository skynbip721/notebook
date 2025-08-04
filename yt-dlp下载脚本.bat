@echo off
setlocal enabledelayedexpansion

:: 设置控制台窗口标题
title YouTube视频下载工具 (yt-dlp)

:: 检查yt-dlp是否安装
where yt-dlp >nul 2>&1
if %errorlevel% neq 0 (
    echo 错误: 未找到yt-dlp，请先安装yt-dlp
    echo 可以从 https://github.com/yt-dlp/yt-dlp 下载
    pause
    exit /b
)

:: 主菜单
:menu
cls
echo ****************************************
echo      YouTube视频批量下载工具 (yt-dlp)
echo ****************************************
echo.
echo 1. 输入视频URL列表下载
echo 2. 输入单个视频URL下载
echo 3. 更改保存位置 (当前: %savepath%)
echo 4. 设置下载格式和质量
echo 5. 退出
echo.
set /p choice=请选择操作 [1-5]:

if "%choice%"=="1" goto batch_download
if "%choice%"=="2" goto single_download
if "%choice%"=="3" goto set_path
if "%choice%"=="4" goto set_format
if "%choice%"=="5" exit

echo 无效选择，请重新输入
pause
goto menu

:: 批量下载
:batch_download
cls
echo 批量下载模式 (可输入多个URL，每行一个)
echo 完成后请在新的一行输入"end"并回车
echo.
echo 当前保存位置: %savepath%
echo.

set "inputfile=%temp%\yt_urls.txt"
echo 请输入视频URL列表: > "%inputfile%"
notepad "%inputfile%"

if not exist "%inputfile%" (
    echo 错误: 未创建URL列表文件
    pause
    goto menu
)

:: 检查文件是否为空或只包含"end"
set "empty=1"
for /f "usebackq delims=" %%a in ("%inputfile%") do (
    if not "%%a"=="end" set "empty=0"
)

if "%empty%"=="1" (
    echo 错误: URL列表为空
    del "%inputfile%"
    pause
    goto menu
)

echo.
echo 开始下载列表中的视频...
echo.

for /f "usebackq delims=" %%a in ("%inputfile%") do (
    if not "%%a"=="end" (
        echo 正在下载: %%a
        yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %format% "%%a"
        echo.
    )
)

del "%inputfile%"
echo 批量下载完成!
pause
goto menu

:: 单个下载
:single_download
cls
echo 单个视频下载模式
echo 当前保存位置: %savepath%
echo.
set /p url=请输入视频URL: 

if "%url%"=="" (
    echo 错误: URL不能为空
    pause
    goto single_download
)

echo.
echo 开始下载视频...
yt-dlp -o "%savepath%\%%(title)s.%%(ext)s" %format% "%url%"

echo.
echo 下载完成!
pause
goto menu

:: 设置保存路径
:set_path
cls
echo 当前保存位置: %savepath%
echo.
echo 请输入新的保存路径 (例如: D:\Videos 或 C:\Users\你的名字\Downloads)
echo 注意: 路径中不要包含引号
echo.
set /p savepath=新保存路径: 

:: 如果用户没有输入，保持原路径
if "%savepath%"=="" (
    set savepath=%cd%
    echo 保持原路径: %savepath%
) else (
    :: 创建目录如果不存在
    if not exist "%savepath%" (
        mkdir "%savepath%"
    )
    echo 保存路径已更新: %savepath%
)

pause
goto menu

:: 设置下载格式和质量
:set_format
cls
echo 当前下载设置: %format%
echo.
echo 请选择下载格式和质量:
echo 1. 最佳质量 (默认)
echo 2. 仅音频 (MP3)
echo 3. 720p视频
echo 4. 1080p视频
echo 5. 自定义格式
echo 6. 返回主菜单
echo.
set /p fmt_choice=请选择 [1-6]: 

if "%fmt_choice%"=="1" set "format=" & goto format_set
if "%fmt_choice%"=="2" set "format=-x --audio-format mp3" & goto format_set
if "%fmt_choice%"=="3" set "format=-f "bestvideo[height<=720]+bestaudio/best[height<=720]"" & goto format_set
if "%fmt_choice%"=="4" set "format=-f "bestvideo[height<=1080]+bestaudio/best[height<=1080]"" & goto format_set
if "%fmt_choice%"=="5" goto custom_format
if "%fmt_choice%"=="6" goto menu

echo 无效选择
pause
goto set_format

:custom_format
cls
echo 当前下载设置: %format%
echo.
echo 请输入自定义yt-dlp格式参数:
echo 例如: -f "bestvideo[height<=720]+bestaudio/best[height<=720]"
echo 或: -x --audio-format mp3
echo 留空则恢复默认设置
echo.
set /p format=自定义格式参数: 

if "%format%"=="" (
    set "format="
    echo 已恢复默认设置
) else (
    echo 自定义格式已设置: %format%
)

pause
goto menu

:format_set
echo 下载格式已更新: %format%
pause
goto menu

:: 初始化变量
if not defined savepath set "savepath=%cd%"
if not defined format set "format="