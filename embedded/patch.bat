@echo off
cd %localappdata%\Temp\CivTemp
for /F "tokens=*" %%i in (Setup.ini) do set %%i
cd \
set civmain=%localappdata%\Temp\CivTemp
cd %civmain%
if exist "%CivPath%\common\FULL.TXT" goto FULL

if exist "%CivPath%\common\CIV1.TXT" (echo a | %civmain%\7z.exe e "%civmain%\Sid-Meiers-Civilization_Patch_Win-3x_EN.zip" -o"%CivPath%\CIVWIN" && rd /s /q "%CivPath%\CIVWIN\Civilization_Win_upgrade_v1.2")
cd \
cd %civmain%
if exist "%CivPath%\common\CIVNET.TXT" (echo a | %civmain%\7z.exe e "%civmain%\Sid-Meiers-CivNet_Patch_Win-3x_EN_Patch-13.zip" -o"%CivPath%\CIVNET" && rd /s /q "%CivPath%\CIVNET\Sid_Meiers_Civnet_patch_13")
cd \
cd %civmain%
if exist "%CivPath%\common\CIV2MGE.TXT" (echo a | %civmain%\7z.exe e mgepatch.7z -o%civmain%\mgepatch && cd mgepatch && mkdir out && cd out && %civmain%\i5comp x ..\data1.cab && xcopy /S /C /H /R /Y *.* "%CivPath%\Civilization II Multiplayer Gold Edition")
cd \
cd %civmain%
if exist "%CivPath%\common\CIV2TOT.TXT" (echo a | %civmain%\7z.exe e totpatch.7z -o%civmain%\totpatch && cd totpatch && mkdir out && cd out && %civmain%\i5comp x ..\data1.cab && xcopy /S /C /H /R /Y *.* "%CivPath%\Test of Time")
cd \
cd %civmain%
if exist "%CivPath%\common\CIV2TOT.TXT" (echo a | %civmain%\7z.exe e totTTP.7z -o%civmain%\totTTP && cd totTTP && mkdir out && cd out && %civmain%\i5comp x ..\data1.cab && xcopy /S /C /H /R /Y *.* "%CivPath%\Test of Time")
goto END

:FULL
echo a | %civmain%\7z.exe e "%civmain%\Sid-Meiers-Civilization_Patch_Win-3x_EN.zip" -o"%CivPath%\CIVWIN"
rd /s /q "%CivPath%\CIVWIN\Civilization_Win_upgrade_v1.2"
echo a | %civmain%\7z.exe e "%civmain%\Sid-Meiers-CivNet_Patch_Win-3x_EN_Patch-13.zip" -o"%CivPath%\CIVNET"
rmdir "%CivPath%\CIVNET\Sid_Meiers_Civnet_patch_13"
echo a | %civmain%\7z.exe e mgepatch.7z -o%civmain%\mgepatch 
cd mgepatch
mkdir out
cd out
%civmain%\i5comp x ..\data1.cab
xcopy /S /C /H /R /Y *.* "%CivPath%\Civilization II Multiplayer Gold Edition"
cd \
cd %civmain%
echo a | %civmain%\7z.exe e totpatch.7z -o%civmain%\totpatch
cd totpatch
mkdir out
cd out
%civmain%\i5comp x ..\data1.cab
echo a | xcopy /S /C /H /R /Y *.* "%CivPath%\Test of Time" 
cd \
cd %civmain%
echo a | %civmain%\7z.exe e totTTP.7z -o%civmain%\totTTP
cd totTTP
mkdir out
cd out
%civmain%\i5comp x ..\data1.cab
xcopy /S /C /H /R /Y *.* "%CivPath%\Test of Time"
cd \
cd %civmain%
goto END

:END
if exist "%CivPath%\common\PATCH.TXT" goto QUIT
echo Done Installing Patches
timeout 10
exit

:QUIT
echo Upgrading Music.....
timeout 5
Powershell -Command [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/American%%20Revolution.mp3' -OutFile '%CivPath%\Test of Time\Music\American Revolution.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Aristotle%%27s%%20Pupil.mp3' -OutFile '%CivPath%\Test of Time\Music\Aristotle_s Pupil.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Augustus%%20Rises.mp3' -OutFile '%CivPath%\Test of Time\Music\Augustus Rises.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Gautama%%20Ponders.mp3' -OutFile '%CivPath%\Test of Time\Music\Gautama Ponders.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Hammurabi%%27s%%20Code.mp3' -OutFile '%CivPath%\Test of Time\Music\Hammurabi_s Code.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Harvest%%20of%%20the%%20Nile.mp3' -OutFile '%CivPath%\Test of Time\Music\Harvest of the Nile.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Jihad.mp3' -OutFile '%CivPath%\Test of Time\Music\Jihad.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Tenochtitlan%%20Revealed.mp3' -OutFile '%CivPath%\Test of Time\Music\Tenochtitlan Revealed.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Civil%%20War.mp3' -OutFile '%CivPath%\Test of Time\Music\The Civil War.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Great%%20War.mp3' -OutFile '%CivPath%\Test of Time\Music\The Great War.mp3'
if exist "%CivPath%\Test of Time" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Shining%%20Path.mp3' -OutFile '%CivPath%\Test of Time\Music\The Shining Path.mp3'
if exist "%CivPath%\Test of Time" move /Y "%CivPath%\Test of Time\Music\Aristotle_s Pupil.mp3" "%CivPath%\Test of Time\Music\Aristotle's Pupil.mp3"
if exist "%CivPath%\Test of Time" move /Y "%CivPath%\Test of Time\Music\Hammurabi_s Code.mp3" "%CivPath%\Test of Time\Music\Hammurabi's Code.mp3"
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/American%%20Revolution.mp3'-OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK12.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Aristotle%%27s%%20Pupil.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK13.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Augustus%%20Rises.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK14.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Gautama%%20Ponders.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK15.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Hammurabi%%27s%%20Code.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK16.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Harvest%%20of%%20the%%20Nile.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK17.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Jihad.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK18.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Tenochtitlan%%20Revealed.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK19.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Civil%%20War.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK20.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Great%%20War.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK21.mp3'
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Shining%%20Path.mp3' -OutFile '%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK22.mp3'

if exist "%CivPath%\Civilization II Multiplayer Gold Edition" cd "%CivPath%\Civilization II Multiplayer Gold Edition\Music" && for %%i in (*.mp3) do %civmain%\lame.exe --decode %%i %%~ni.wav

echo Done Installing Patches...
timeout 10
exit
