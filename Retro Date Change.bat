@echo off
:beginning
mode con: cols=40 lines=30
SET NAME=Retro Proxy Date Changer
TITLE %NAME%
set mainfolder=%CD%
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
rem CHECK EVERYTHING
set proxy_running=false
tasklist /FI "IMAGENAME eq python.exe" 2>NUL | find /I /N "python.exe">NUL
if "%ERRORLEVEL%"=="0" (
echo    Retro Proxy is running!
ping -n 2 127.0.0.1>nul
rem echo.
rem echo    Stop it before changing address!
rem ping -n 5 127.0.0.1>nul
rem exit
set proxy_running=true
)
if not exist "%mainfolder%\retro_proxy" (
echo    Retro Proxy missing!
goto error_install
)
if not exist "%mainfolder%\retro_python" (
echo    Python missing!
goto error_install
)
if not exist "%mainfolder%\retro_proxy\config.json" (
echo    Config is missing!
goto error_install
)

if exist "%mainfolder%\retro_tools\proxy_date.txt" set /p current_proxy_date=<"%mainfolder%\retro_tools\proxy_date.txt"
if not exist "%mainfolder%\retro_tools\proxy_date.txt" set current_proxy_date=20011025

echo    Current proxy date: %current_proxy_date%
ping -n 2 127.0.0.1>nul
echo.
set /P new_proxy_date=Enter date YYYYMMDD (X=cancel):
if "%new_proxy_date%"=="" goto error_empty_address
if "%new_proxy_date%"=="x" exit
if "%new_proxy_date%"=="X" exit

if %proxy_running%==true (
start "" "Retro Proxy Stop.bat"
ping -n 5 127.0.0.1>nul
)

:config_apply_address
echo.
echo    Applying date to config...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\fart.exe" "%mainfolder%\retro_proxy\etc\config\config.yml" "host: 0.0.0.0" "host: 127.0.0.1"
setlocal enableextensions disabledelayedexpansion

    set "search=%current_proxy_date%"
    set "replace=%new_proxy_date%"

    set "textFile=%mainfolder%\retro_proxy\config.json"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        >>"%textFile%" echo(!line:%search%=%replace%!
        endlocal
    )
endlocal
>"%mainfolder%\retro_tools\proxy_date.txt" echo %new_proxy_date%

:end_install
echo.
echo    Done!
ping -n 2 127.0.0.1>nul

if %proxy_running%==true (
start "" "Retro Proxy Start.bat"
)

exit

:error_empty_address
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Empty date entered!
ping -n 5 127.0.0.1>nul
exit

:error_install
echo.
echo    Run Retro Proxy Setup.bat
echo    to complete installation
ping -n 5 127.0.0.1>nul
exit
