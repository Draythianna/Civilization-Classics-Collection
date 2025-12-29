@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ===============================================
REM Civilization Classics Collection - install.bat
REM ===============================================

set "CIVMAIN=%ProgramData%\Temp\CivTemp"
for /f "usebackq delims=" %%i in ("%CIVMAIN%\Setup.ini") do set "%%i"

:main
set "civmain=%CIVMAIN%"
cd "%civmain%"
cls

REM --------------------------------------------------
REM Helper: select xdelta executable
REM   - If force32.txt exists, prefer 32-bit xdelta
REM   - Else prefer 64-bit xdelta when available
REM --------------------------------------------------
:select_xdelta
set "XDELTA32=%civmain%\xdelta3-3.0.11-i686.exe"
set "XDELTA64=%civmain%\xdelta3-3.0.11-x86_64.exe"
set "XDELTA_EXE="

if exist "%CivPath%\common\force32.txt" (
  if exist "%XDELTA32%" set "XDELTA_EXE=%XDELTA32%"
) else (
  if exist "%XDELTA64%" set "XDELTA_EXE=%XDELTA64%"
  if not defined XDELTA if exist "%XDELTA32%" set "XDELTA_EXE=%XDELTA32%"
)

if not defined XDELTA_EXE (
  echo "ERROR: xdelta not found (need xdelta3-3.0.11-i686.exe and/or xdelta3-3.0.11-x86_64.exe in %civmain%)"
  exit /b 1
)

set "LAME="
if exist "%civmain%\x64\lame.exe" set "LAME=%civmain%\x64\lame.exe"
if exist "%civmain%\x86\lame.exe" set "LAME=%civmain%\x86\lame.exe"


cd \
if exist "%CivPath%\common\FULL.TXT" goto full
goto multi

:full
cd %civmain%
%civmain%\7z.exe x civ2xp64patcher.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
%civmain%\7z.exe x Civ2UIA.v1.21.5.2785.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
%civmain%\7z.exe x civ2patch-v1.01a.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
echo y |copy Civ2x64EditboxPatcher.exe "%CivPath%\Civilization II Multiplayer Gold Edition\"
%civmain%\7z.exe x Civ2MGE_v19.7z -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
%civmain%\7z.exe x TOTPPv018.4.zip -o"%CivPath%\Test of Time\" -y
%civmain%\7z.exe e 90936-tot_corrected_dlls.rar -o"%CivPath%\Test of Time\" -y
rd /s /q "%CivPath%\Test of Time\ToT corrected DLLs\"
%civmain%\7z.exe x ExtendedMusic.7z.exe -o"%CivPath%\Test of Time\" -y
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\civ.bak"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.bak
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Right_mouse_click"
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Without_very_large_maps"
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2.diff" civ2.music.exe
%XDELTA_EXE% -v -v -f -d -s Civ2Map.exe "%civmain%\Civ2Map.diff" Civ2Map.fixes.exe
%XDELTA_EXE% -v -v -f -d -s Civ2.exe "%civmain%\civ2_right.diff" Civ2Map.fixes.exe
%XDELTA_EXE% -v -v -f -d -s Civ2.exe "%civmain%\civ2_right.diff" Right_mouse_click\civ2.rightclick.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\mgepatched64.diff" civ2.x64.exe
%XDELTA_EXE% -v -v -f -d -s Civ2Map.exe "%civmain%\civmapsmallmaps.diff" Without_very_large_maps\Civ2Map.smaps.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\smallmaps.diff" Without_very_large_maps\civ2.smaps.exe
echo y | copy Right_mouse_click\civ2.rightclick.exe civ2.rightclick.exe
echo y | copy civ2.music.exe civ2.exe
echo y | copy Civ2Map.fixes.exe Civ2Map.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe civ2.smaps.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe Civ2Map.smaps.exe
echo y | copy Right_mouse_click\civ2.rightclick.exe civ2.rightclick.exe
cd\
%civmain%\7z.exe e 90936-tot_corrected_dlls.rar -o"%CivPath%\Test of Time\" -y
%civmain%\7z.exe x TOTPPv018.4.zip -o"%CivPath%\Test of Time\" -y
rd /s /q "%CivPath%\Test of Time\ToT corrected DLLs\"
%civmain%\7z.exe x ExtendedMusic.7z -o"%CivPath%\Test of Time\" -y
cd "%CivPath%\Test of Time"
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\totpatched64.diff" civ2.x64.exe 
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
echo y | copy "%CivPath%\Test of Time\civ2.fixes.exe" "%CivPath%\Test of Time\civ2.exe"
goto end

:multi
if exist "%CivPath%\common\CIV2MGE.TXT" goto mge
:mge
cd %civmain%
%civmain%\7z.exe x civ2xp64patcher.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
%civmain%\7z.exe x Civ2UIA.v1.21.5.2785.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
%civmain%\7z.exe x civ2patch-v1.01a.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo y | copy Civ2x64EditboxPatcher.exe "%CivPath%\Civilization II Multiplayer Gold Edition\"
%civmain%\7z.exe x Civ2MGE_v19.7z -o"%CivPath%\Civilization II Multiplayer Gold Edition\" -y
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Right_mouse_click"
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Without_very_large_maps"
cd "%CivPath%\Civilization II Multiplayer Gold Edition\"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\civ.bak"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.bak"
%XDELTA_EXE% -v -v -f -d -s Civ2Map.exe "%civmain%\Civ2Map.diff" Civ2Map.fixes.exe
%XDELTA_EXE% -v -v -f -d -s Civ2Map.exe "%civmain%\civmapsmallmaps.diff" Without_very_large_maps\Civ2Map.smaps.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\smallmaps.diff" Without_very_large_maps\civ2.smaps.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2.diff" civ2.music.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2_right.diff" Right_mouse_click\civ2.rightclick.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\mgepatched64.diff" civ2.x64.exe
echo y | copy civ2.music.exe civ2.exe
echo y | copy Civ2Map.fixes.exe Civ2Map.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe civ2.smaps.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe Civ2Map.smaps.exe
echo y | copy Right_mouse_click\civ2.rightclick.exe civ2.rightclick.exe
goto multi2

:multi2
if exist "%CivPath%\common\CIV2TOT.TXT" goto tot
goto end
:tot
cd %civmain%
%civmain%\7z.exe e 90936-tot_corrected_dlls.rar -o"%CivPath%\Test of Time\" -y
%civmain%\7z.exe x TOTPPv018.4.zip -o"%CivPath%\Test of Time\" -y
rd /s /q "%CivPath%\Test of Time\ToT corrected DLLs\"
%civmain%\7z.exe x ExtendedMusic.7z -o"%CivPath%\Test of Time\" -y
cd "%CivPath%\Test of Time"
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
echo y | copy "%CivPath%\Test of Time\civ2.fixes.exe" "%CivPath%\Test of Time\civ2.exe"
%XDELTA_EXE% -v -v -f -d -s civ2.exe "%civmain%\totpatched64.diff" civ2.x64.exe
goto end

:end
echo Modern Upgrades Installed...
timeout 5
exit /b 0
