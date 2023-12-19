@echo off
SET NAME=Retro Proxy Server
TITLE %NAME%
COLOR 09

echo.
echo    Retro Proxy Server
echo.
echo    Stopping...
echo.
tasklist /FI "IMAGENAME eq python.exe" 2>NUL | find /I /N "python.exe">NUL
if "%ERRORLEVEL%"=="0" taskkill /f /im python.exe
exit
