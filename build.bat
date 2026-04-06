@echo off
setlocal

set "CC=gcc"
set "CFLAGS=-Wall -Wextra -g -Iinclude"
set "OBJ_DIR=build\obj"
set "BIN_DIR=bin"

if not exist "%OBJ_DIR%" mkdir "%OBJ_DIR%"
if not exist "%BIN_DIR%" mkdir "%BIN_DIR%"

echo Building sort_demo.exe and sort_test.exe...
%CC% %CFLAGS% -c src\sort.c -o %OBJ_DIR%\sort.o || goto :error
%CC% %CFLAGS% -c src\main.c -o %OBJ_DIR%\main.o || goto :error
%CC% %CFLAGS% -c tests\sort_test.c -o %OBJ_DIR%\sort_test.o || goto :error
%CC% %CFLAGS% -o %BIN_DIR%\sort_demo.exe %OBJ_DIR%\sort.o %OBJ_DIR%\main.o || goto :error
%CC% %CFLAGS% -o %BIN_DIR%\sort_test.exe %OBJ_DIR%\sort.o %OBJ_DIR%\sort_test.o || goto :error

echo Build completed successfully!
echo Run bin\sort_demo.exe for the demo.
echo Run bin\sort_test.exe for the tests.
exit /b 0

:error
echo Build failed!
exit /b 1
