@echo off
:beginning
mode con: cols=40 lines=30
SET NAME=Retro Proxy Server
TITLE %NAME%
set mainfolder=%CD%
cls
more < "%mainfolder%\retro_tools\header_start.txt"
echo.
rem CHECK EVERYTHING
tasklist /FI "IMAGENAME eq python.exe" 2>NUL | find /I /N "python.exe">NUL
if "%ERRORLEVEL%"=="0" (
echo    Retro Proxy is already running!
ping -n 3 127.0.0.1>nul
goto ending
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

rem do it every time in case repack is moved
:fix_python_paths
set properpath=%mainfolder%
set "properpath=%properpath:\=/%"
rem restore original waybackproxy.py
if exist "%mainfolder%\retro_proxy\backup\waybackproxy.py" (
if exist "%mainfolder%\retro_proxy\waybackproxy.py" del "%mainfolder%\retro_proxy\waybackproxy.py">nul
xcopy /y "%mainfolder%\retro_proxy\backup\waybackproxy.py" "%mainfolder%\retro_proxy">nul
)
rem add core path to sys path
cls
more < "%mainfolder%\retro_tools\header_start.txt"
echo.
echo    Fixing Python Path...
ping -n 2 127.0.0.1>nul
set properpath=%mainfolder%
set "properpath=%properpath:\=/%"
setlocal enableextensions disabledelayedexpansion

    set "search=import base64, datetime"
    set "replace=import base64, sys;sys.path.insert^(0, '%properpath%/retro_proxy/'^);import datetime"

    set "textFile=%mainfolder%\retro_proxy\waybackproxy.py"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        >>"%textFile%" echo(!line:%search%=%replace%!
        endlocal
    )
endlocal

:start_core
cd "%mainfolder%\retro_proxy"
echo.
echo    Starting Retro Proxy...
ping -n 2 127.0.0.1>nul
start "" "%mainfolder%\retro_tools\start_retro_proxy.bat"
rem start "" "%mainfolder%\retro_python\python.exe" "%mainfolder%\retro_proxy\waybackproxy.py"
cd "%mainfolder%"

:ending
exit

:error_install
echo.
echo    Run Retro Proxy Setup.bat
echo    to complete installation
ping -n 5 127.0.0.1>nul
exit
