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
tasklist /FI "IMAGENAME eq python.exe" 2>NUL | find /I /N "python.exe">NUL
if not "%ERRORLEVEL%"=="0" (
echo    Retro Proxy is not running!
ping -n 3 127.0.0.1>nul
exit
)
echo    Stopping Retro Proxy...
ping -n 2 127.0.0.1>nul
cd "%mainfolder%\retro_tools"
start "" /min "%mainfolder%\retro_tools\stop_retro_proxy.bat"
cd "%mainfolder%"
echo.
echo    Done!
ping -n 2 127.0.0.1>nul

:ending
rem restore original main.py
if exist "%mainfolder%\retro_proxy\backup\waybackproxy.py" (
if exist "%mainfolder%\retro_proxy\waybackproxy.py" del "%mainfolder%\retro_proxy\waybackproxy.py"
xcopy /y "%mainfolder%\retro_proxy\backup\waybackproxy.py" "%mainfolder%\retro_proxy"
)
exit

:error_install
echo.
echo    Run Retro Proxy Setup.bat
echo    to complete installation
ping -n 5 127.0.0.1>nul
exit
