@echo off
cd %localappdata%\TEMP\CivTemp
for /F "tokens=*" %%i in (Setup.ini) do set %%i
set civmain=%localappdata%\TEMP\CivTemp
cd %civmain%

if exist "%CivPath%\common\FULL.TXT" goto full

if exist "%CivPath%\common\CIV2MGE.TXT" goto civ2mge

if exist "%CivPath%\common\CIV2TOT.TXT" goto civ2tot

:civ2mge
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Right_mouse_click"
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Without_very_large_maps"
cd "%CivPath%\Civilization II Multiplayer Gold Edition\"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.nocd.bak"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.bak"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.bak"
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2Map.exe "%civmain%\Civ2Map.diff" Civ2Map.fixes.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2Map.exe "%civmain%\Civ2Map.diff" Civ2Map.fixes.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2Map.exe "%civmain%\civmapsmallmaps.diff" Without_very_large_maps\Civ2Map.smaps.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2Map.exe "%civmain%\civmapsmallmaps.diff" Without_very_large_maps\Civ2Map.smaps.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2Map.exe "%civmain%\smallmaps.diff" Without_very_large_maps\civ2.smaps.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2Map.exe "%civmain%\smallmaps.diff" Without_very_large_maps\civ2.smaps.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\civ2.diff" civ2.music.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\civ2.diff" civ2.music.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2.exe "%civmain%\civ2_right.diff" civ2.rightclick.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\mgepatched64.diff" civ2.x64.exe
echo y | copy civ2.music.exe civ2.exe
echo y | copy Civ2Map.fixes.exe Civ2Map.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe civ2.smaps.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe Civ2Map.smaps.exe
cd\

:civ2tot
cd "%CivPath%\Test of Time"
echo y | copy "%CivPath%\Test of Time\civ2.exe" "%CivPath%\Test of Time\civ2.nocd.bak"
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
echo y | copy "%CivPath%\Test of Time\civ2.fixes.exe" "%CivPath%\Test of Time\civ2.exe"
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\totpatched64.diff" civ2.x64.exe
cd\
goto end

:full
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Right_mouse_click"
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\Without_very_large_maps"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\Right_mouse_click\civ2.exe"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\civ2.nocd.bak"
echo y | copy "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.exe" "%CivPath%\Civilization II Multiplayer Gold Edition\Civ2Map.bak" 
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
cd "%CivPath%\Civilization II Multiplayer Gold Edition"
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\civ2.diff" civ2.music.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\civ2.diff" civ2.music.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2Map.exe "%civmain%\Civ2Map.diff" Civ2Map.fixes.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2Map.exe "%civmain%\Civ2Map.diff" Civ2Map.fixes.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2.exe "%civmain%\civ2_right.diff" Civ2Map.fixes.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2.exe "%civmain%\civ2_right.diff" Right_mouse_click\civ2.rightclick.exe
%civmain%\xdelta3-3.0.11-i686.exe -d -s civ2.exe "%civmain%\mgenocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\mgepatched64.diff" civ2.x64.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2Map.exe "%civmain%\civmapsmallmaps.diff" Without_very_large_maps\Civ2Map.smaps.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2Map.exe "%civmain%\civmapsmallmaps.diff" Without_very_large_maps\Civ2Map.smaps.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s Civ2Map.exe "%civmain%\smallmaps.diff" Without_very_large_maps\civ2.smaps.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s Civ2Map.exe "%civmain%\smallmaps.diff" Without_very_large_maps\civ2.smaps.exe
echo y | copy Right_mouse_click\civ2.rightclick.exe civ2.rightclick.exe
echo y | copy civ2.music.exe civ2.exe
echo y | copy Civ2Map.fixes.exe Civ2Map.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe civ2.smaps.exe
echo y | copy Without_very_large_maps\civ2.smaps.exe Civ2Map.smaps.exe
cd\
cd "%CivPath%\Test of Time"
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
if exist "%CivPath%\common\force32.txt" %civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\totnocd.diff" civ2.nocd.exe
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\totpatched64.diff" civ2.x64.exe 
%civmain%\xdelta3-3.0.11-x86_64.exe -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
%civmain%\xdelta3-3.0.11-i686.exe -f -d -s civ2.exe "%civmain%\civ2tot.diff" civ2.fixes.exe
echo y | copy "%CivPath%\Test of Time\civ2.fixes.exe" "%CivPath%\Test of Time\civ2.exe"
goto end

:end
cd "%civmain%"
echo NoCD's Patched...
timeout 5
exit
