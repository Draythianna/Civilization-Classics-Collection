@echo off
setlocal EnableExtensions

set "CIVMAIN=%ProgramData%\Temp\CivTemp"

rem --- Read Setup.ini safely (no delayed expansion while parsing)
setlocal DisableDelayedExpansion
for /f "usebackq eol=; tokens=1* delims==" %%A in ("%CIVMAIN%\Setup.ini") do (
    rem Skip empty keys
    if not "%%A"=="" set "%%A=%%B"
)
setlocal EnableDelayedExpansion

REM --------------------------------------------------
REM Helper: select xdelta executable
REM   - If force32.txt exists, prefer 32-bit xdelta
REM   - Else prefer 64-bit xdelta when available
REM --------------------------------------------------
set "XDELTA32=%civmain%\xdelta3-3.0.11-i686.exe"
set "XDELTA64=%civmain%\xdelta3-3.0.11-x86_64.exe"
set "XDELTA_EXE="

if exist "%XDELTA32%" set "XDELTA_EXE=%XDELTA32%"
if exist "%XDELTA64%" set "XDELTA_EXE=%XDELTA64%"
if exist "%CivPath%\common\force32.txt" set "XDELTA_EXE=%XDELTA32%"


:main
set "civmain=%CIVMAIN%"
echo "Workspace %CIVMAIN%"
echo "CivPath %CivPath%"
cd "%civmain%"
REM --------------------------------------------------
REM Choose which NoCD routine to run based on marker files
REM --------------------------------------------------
if exist "%CivPath%\common\FULL.TXT" goto full
if exist "%CivPath%\common\CIV2MGE.TXT" goto civ2mge
if exist "%CivPath%\common\CIV2TOT.TXT" goto civ2tot

echo "No marker found (FULL.TXT/CIV2MGE.TXT/CIV2TOT.TXT). Nothing to do."
goto end

:civ2mge
cd "%CivPath%\Civilization II Multiplayer Gold Edition\"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.nocd.bak"
if exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
if not exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
cd\

:civ2tot
cd "%CivPath%\Test of Time"
echo y | copy "%CivPath%\Test of Time\civ2.exe" "%CivPath%\Test of Time\civ2.nocd.bak"
if exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
if not exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
cd\
goto end

:full
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.nocd.bak"
if exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
if not exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
cd "%CivPath%\Civilization II Multiplayer Gold Edition"
cd\
cd "%CivPath%\Test of Time"
if exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
if not exist "%CivPath%\common\force32.txt" "%XDELTA_EXE%" -f -v -v -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
goto end

:end
cd "%civmain%"
echo NoCD's Patched...
timeout 5
endlocal
