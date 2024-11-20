@echo off
set civmain=%localappdata%\Temp\CivTemp\
cd %civmain%
for /F "tokens=*" %%i in (Setup.ini) do set %%i
mkdir "%CivPath%\common\extras"
echo a | %civmain%\7z x extras.7z -o"%CivPath%\common\extras"
echo Extra's Installed...
timeout 5
exit