@echo off
cd %localappdata%\TEMP\CivTemp
for /F "tokens=*" %%i in (Setup.ini) do set %%i
cd \
set civmain=%localappdata%\Temp\CivTemp\
cd %civmain%
if exist "%CivPath%\common\FULL.TXT" goto full
goto multi

:full
echo a | %civmain%\7z x civ2xp64patcher.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x Civ2UIA.v1.20.3.770.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x civ2patch-v1.01a.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo y |copy Civ2x64EditboxPatcher.exe "%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x Civ2MGE_v17.7z -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x TOTPPv018.4.zip -o"%CivPath%\Test of Time\"
echo a | %civmain%\7z e 90936-tot_corrected_dlls.rar -o"%CivPath%\Test of Time\"
rd /s /q "%CivPath%\Test of Time\ToT corrected DLLs\"
echo a | %civmain%\7z x ExtendedMusic.7z -o"%CivPath%\Test of Time\"
goto end

:multi
if exist "%CivPath%\common\CIV2MGE.TXT" goto mge
:mge
echo a | %civmain%\7z x civ2xp64patcher.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x Civ2UIA.v1.20.3.770.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x civ2patch-v1.01a.zip -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
echo y | copy Civ2x64EditboxPatcher.exe "%CivPath%\Civilization II Multiplayer Gold Edition\"
echo a | %civmain%\7z x Civ2MGE_v17.7z -o"%CivPath%\Civilization II Multiplayer Gold Edition\"
goto multi2

:multi2
if exist "%CivPath%\common\CIV2TOT.TXT" goto tot
goto end
:tot
echo a | %civmain%\7z e 90936-tot_corrected_dlls.rar -o"%CivPath%\Test of Time\"
echo a | %civmain%\7z x TOTPPv018.4.zip -o"%CivPath%\Test of Time\"
rd /s /q "%CivPath%\Test of Time\ToT corrected DLLs\"
echo a | %civmain%\7z x ExtendedMusic.7z -o"%CivPath%\Test of Time\"
goto end

:end
echo Modern Upgrades Installed...
timeout 5
exit
