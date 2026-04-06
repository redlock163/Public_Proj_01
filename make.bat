@echo off
setlocal

set "MAKE_EXE=C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe"

if not exist "%MAKE_EXE%" (
    echo Error: mingw32-make was not found at:
    echo   %MAKE_EXE%
    exit /b 1
)

if "%~1"=="" goto :usage_and_build

"%MAKE_EXE%" %*
exit /b %errorlevel%

:usage_and_build
echo Usage:
echo   make.bat              Build the project
echo   make.bat clean        Remove build outputs
echo   make.bat run          Build and run the demo
echo   make.bat test         Build and run the tests
echo.
echo Using:
echo   %MAKE_EXE%
echo.
"%MAKE_EXE%"
exit /b %errorlevel%
