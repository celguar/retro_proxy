@echo off
:beginning
mode con: cols=40 lines=30
SET NAME=Retro Proxy Installer
TITLE %NAME%
set mainfolder=%CD%
cls
more < "%mainfolder%\retro_tools\header_install.txt"
if not exist "%mainfolder%\retro_downloads" mkdir "%mainfolder%\retro_downloads"
:core_download
rem if exist "%mainfolder%\retro_proxy" goto python_download
rem if exist "%mainfolder%\retro_downloads\retro_proxy_master.zip" goto core_extract
if exist "%mainfolder%\retro_downloads\retro_proxy_master.zip" del "%mainfolder%\retro_downloads\retro_proxy_master.zip"
echo.
echo    Downloading Retro Proxy...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\wget.exe" -q --show-progress "https://github.com/The-Alpha-Project/alpha-core/archive/refs/heads/master.zip" -O "%mainfolder%\retro_proxy_master.zip"
curl -L -o "%mainfolder%\retro_downloads\retro_proxy_master.zip" "https://github.com/richardg867/WaybackProxy/archive/refs/heads/master.zip"
:core_extract
if exist "%mainfolder%\retro_downloads\retro_proxy_master.zip" (
if exist "%mainfolder%\retro_proxy" rmdir /Q /S "%mainfolder%\retro_proxy"
)
rem if exist "%mainfolder%\retro_proxy" goto python_download
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Extracting Retro Proxy...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\7za.exe" -y -spf e "%mainfolder%\retro_proxy_master.zip" > nul
tar -xf "%mainfolder%\retro_downloads\retro_proxy_master.zip"
rename "%mainfolder%\WaybackProxy-master" "retro_proxy"
rem CHECK INSTALL
if not exist "%mainfolder%\retro_proxy" (
echo    Failed to install Retro Proxy!
ping -n 2 127.0.0.1>nul
echo.
echo    Possible vcredist++ missing
ping -n 2 127.0.0.1>nul
echo.
echo    Exiting installer...
ping -n 3 127.0.0.1>nul
exit
)
:python_download
if exist "%mainfolder%\retro_downloads\python_3.9.9_win64.zip" goto python_extract
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Downloading Python 3.9...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\wget.exe" -q --show-progress "https://www.python.org/ftp/python/3.9.9/python-3.9.9-embed-amd64.zip" -O "%mainfolder%\python_3.9.9_win64.zip"
curl -L -o "%mainfolder%\retro_downloads\python_3.9.9_win64.zip" "https://www.python.org/ftp/python/3.9.9/python-3.9.9-embed-amd64.zip"
:python_extract
if exist "%mainfolder%\retro_python" goto python_install
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Extracting Python...
ping -n 2 127.0.0.1>nul
if not exist "%mainfolder%\retro_python" mkdir "%mainfolder%\retro_python"
rem "%mainfolder%\retro_tools\7za.exe" -y -spf e -o"%mainfolder%\retro_python" "%mainfolder%\python_3.9.9_win64.zip" > nul
tar -xf "%mainfolder%\retro_downloads\python_3.9.9_win64.zip" -C "%mainfolder%\retro_python"
if not exist "%mainfolder%\retro_python\python.exe" (
echo    Failed to install Python!
ping -n 2 127.0.0.1>nul
echo.
echo    Possible vcredist++ missing
ping -n 2 127.0.0.1>nul
echo.
echo    Exiting installer...
ping -n 3 127.0.0.1>nul
exit
)

:python_install
if exist "%mainfolder%\retro_downloads\get-pip.py" goto pip_install
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Preparing Python...
ping -n 2 127.0.0.1>nul
:pip_download
rem if exist "%mainfolder%\retro_python\get-pip.py" goto pip_install
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Preparing Python...
echo.
echo    Downloading Pip...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\wget.exe" -q --show-progress "https://bootstrap.pypa.io/get-pip.py" -O "%mainfolder%\retro_python\get-pip.py"
curl -L -o "%mainfolder%\retro_downloads\get-pip.py" "https://bootstrap.pypa.io/get-pip.py"
:pip_install
if exist "%mainfolder%\retro_python\Scripts\pip3.exe" goto pip_requirements
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Preparing Python...
echo.
echo    Downloading Pip...
echo.
echo    Installing Pip...
ping -n 2 127.0.0.1>nul
cd "%mainfolder%\retro_python"
"%mainfolder%\retro_python\python.exe" "%mainfolder%\retro_downloads\get-pip.py"
cd "%mainfolder%"
:pip_requirements
if exist "%mainfolder%\retro_python\Lib\site-packages\urllib3" goto backup_main_py
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Preparing Python...
echo.
echo    Downloading Pip...
echo.
echo    Installing Pip...
echo.
echo    Enabling Pip...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\fart.exe" "%mainfolder%\retro_python\python39._pth" "#import site" "import site"
setlocal enableextensions disabledelayedexpansion

    set "search=#import site"
    set "replace=import site"

    set "textFile=%mainfolder%\retro_python\python39._pth"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        >>"%textFile%" echo(!line:%search%=%replace%!
        endlocal
    )
endlocal
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Preparing Python...
echo.
echo    Downloading Pip...
echo.
echo    Installing Pip...
echo.
echo    Enabling Pip...
echo.
echo    Pip Enabled!
ping -n 2 127.0.0.1>nul
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Installing Python Requirements...
ping -n 2 127.0.0.1>nul
if not exist "%mainfolder%\retro_proxy\requirements.txt" xcopy /y "%mainfolder%\retro_tools\requirements.txt" "%mainfolder%\retro_proxy">nul
cd "%mainfolder%\retro_proxy"
"%mainfolder%\retro_python\python.exe" -m pip install -r requirements.txt
cd "%mainfolder%"
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Python Requirements Installed!
ping -n 2 127.0.0.1>nul

:backup_main_py
if not exist "%mainfolder%\retro_proxy\backup" mkdir "%mainfolder%\retro_proxy\backup">nul
if not exist "%mainfolder%\retro_proxy\backup\waybackproxy.py" xcopy /y "%mainfolder%\retro_proxy\waybackproxy.py" "%mainfolder%\retro_proxy\backup">nul

:end_install
cd "%mainfolder%"
cls
more < "%mainfolder%\retro_tools\header_install.txt"
echo.
echo    Retro Proxy Setup Complete!
ping -n 3 127.0.0.1>nul
if not exist "%mainfolder%\retro_tools\proxy_date.txt" (
set current_proxy_date=20011025
>"%mainfolder%\retro_tools\proxy_date.txt" echo %current_proxy_date%
echo.
echo    Date set to %current_proxy_date%
ping -n 4 127.0.0.1>nul
exit
)

set /p current_proxy_date=<"%mainfolder%\retro_tools\proxy_date.txt"
:config_apply_address
echo.
echo    Applying old date to config...
ping -n 2 127.0.0.1>nul
rem "%mainfolder%\retro_tools\fart.exe" "%mainfolder%\retro_proxy\etc\config\config.yml" "host: 0.0.0.0" "host: 127.0.0.1"
setlocal enableextensions disabledelayedexpansion

    set "search=20011025"
    set "replace=%current_proxy_date%"

    set "textFile=%mainfolder%\retro_proxy\config.json"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
        >>"%textFile%" echo(!line:%search%=%replace%!
        endlocal
    )
endlocal
echo.
echo    Date set to %current_proxy_date%
ping -n 4 127.0.0.1>nul
exit
