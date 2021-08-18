@echo off
title Safe Mode Boot Tool v1.0
mode 50,15
REM Safe Mode Boot Tool v1.0 by /u/cuddlychops06
REM Updated: September 4th, 2013 8:38pm

:winxpcheck
%SystemRoot%\System32\reg.exe query "HKLM\Software\Microsoft\Windows NT\CurrentVersion" /v ProductName | find "Microsoft Windows XP" >nul 2>nul
if %errorlevel% EQU 0 (goto :nosupport) else (goto :start)

:start
echo.
echo        ************************************
echo        *       Safe Mode Boot Tool        *
echo        *   by: /u/cuddlychops06 (c)2013   *
echo        ************************************
echo.
echo What would you like to do?
echo --------------------------
echo.
echo 1) Boot Safe Mode
echo 2) Boot Safe Mode with Networking
echo 3) Boot Safe Mode with Command Prompt
echo 4) Repair SM Boot Loop / Start Normal Mode
echo.
set /p choice=[Select a number]: 
if '%choice%'=='1' goto :sm
if '%choice%'=='2' goto :smwn
if '%choice%'=='3' goto :smwcp
if '%choice%'=='4' goto :repair

:sm
echo.
echo Booting Safe Mode...
ping -n 3 127.0.0.1 >nul
bcdedit /set {default} safeboot minimal >nul
shutdown -r -t 3
exit

:smwn
echo.
echo Booting Safe Mode with Networking...
ping -n 3 127.0.0.1 >nul
bcdedit /set {default} safeboot network >nul
shutdown -r -t 3
exit

:smwcp
echo.
echo Booting Safe Mode with Command Prompt...
ping -n 3 127.0.0.1 >nul
bcdedit /set {default} safeboot minimal >nul
bcdedit /set {default} safebootalternateshell yes >nul
shutdown -r -t 3
exit

:repair
echo.
echo Repairing Boot Options...
ping -n 3 127.0.0.1 >nul
bcdedit /deletevalue {default} safeboot >nul
echo Booting Normal Mode...
ping -n 3 127.0.0.1 >nul
shutdown -r -t 3
exit

:nosupport
cls
echo Windows XP not supported. Exiting.
ping -n 4 127.0.0.1 >nul
exit