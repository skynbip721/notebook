@echo off
:: 检查是否以管理员身份运行
NET SESSION >nul 2>&1
if %errorLevel% neq 0 (
    echo Request admin privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c "%~f0"' -Verb RunAs"
    exit /b
)

:: 设置TLS 1.2以确保安全连接
powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor 3072"

:: 执行MassGrave激活脚本
powershell -Command "irm massgrave.dev/get.ps1 | iex"