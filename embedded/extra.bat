@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ===============================================
REM Civilization Classics Collection - extra.bat
REM ===============================================

set "CIVMAIN=%ProgramData%\Temp\CivTemp"
for /f "usebackq delims=" %%i in ("%CIVMAIN%\Setup.ini") do set "%%i"

:main
set "civmain=%CIVMAIN%"
cls

mkdir "%CivPath%\common\extras"
echo a | %civmain%\7z x extras.7z -o"%CivPath%\common\extras"
echo Extra's Installed...

timeout 5
exit /b 0
