@echo off
SET NAME=Retro Proxy Server
TITLE %NAME%
COLOR 07

echo.
echo    Retro Proxy Server
echo.
echo    Starting...
echo.
"..\retro_python\python.exe" "%mainfolder%\retro_proxy\waybackproxy.py"\
exit
