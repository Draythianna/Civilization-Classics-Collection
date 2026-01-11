@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ===============================================
REM Civilization Classics Collection - patch.bat
REM ===============================================

set "CIVMAIN=%ProgramData%\Temp\CivTemp"
for /f "usebackq delims=" %%i in ("%CIVMAIN%\Setup.ini") do set "%%i"

REM --------------------------------------------------
REM Select LAME (x64 vs x86)
REM   Prefers x64 on 64-bit Windows when available.
REM   Falls back to x86 if needed.
REM --------------------------------------------------
set "LAME="
set "LAME64=%CIVMAIN%\x64\lame.exe"
set "LAME86=%CIVMAIN%\x86\lame.exe"

REM Detect OS bitness safely
set "IS64=0"
if defined PROCESSOR_ARCHITEW6432 set "IS64=1"
if /I "%PROCESSOR_ARCHITECTURE%"=="AMD64" set "IS64=1"
if /I "%PROCESSOR_ARCHITECTURE%"=="ARM64" set "IS64=1"
if exist "%CivPath%\common\force32.txt" set "IS64=0"

if "%IS64%"=="1" (
  if exist "%LAME64%" (
    set "LAME=%LAME64%"
  ) else if exist "%LAME86%" (
    set "LAME=%LAME86%"
  )
) else (
  if exist "%LAME86%" (
    set "LAME=%LAME86%"
  )
)

if not defined LAME (
  echo "ERROR: lame.exe not found. Expected %LAME64% or %LAME86%"
  exit /b 1
)

echo "Using LAME: %LAME%"

:main
set "civmain=%CIVMAIN%"
cd \
if exist "%CivPath%\common\FULL.TXT" goto FULL

cd \
pushd "%CIVMAIN%" || exit /b 1
if exist "%CivPath%\common\CIV1.TXT" (
  "%civmain%\7z.exe" e "%civmain%\Sid-Meiers-Civilization_Patch_Win-3x_EN.zip" -o"%CivPath%\CIVWIN" -y
  rd /s /q "%CivPath%\CIVWIN\Civilization_Win_upgrade_v1.2"
)

cd \
pushd "%CIVMAIN%" || exit /b 1
if exist "%CivPath%\common\CIVNET.TXT" (
  "%civmain%\7z.exe" e "%civmain%\Sid-Meiers-CivNet_Patch_Win-3x_EN_Patch-13.zip" -o"%CivPath%\CIVNET" -y
  rd /s /q "%CivPath%\CIVNET\Sid_Meiers_Civnet_patch_13"
)

cd \
pushd "%CIVMAIN%" || exit /b 1
if exist "%CivPath%\common\CIV2MGE.TXT" (
  "%civmain%\7z.exe" e "%civmain%\mgepatch.7z" -o"%civmain%\mgepatch" -y
  cd "%civmain%\mgepatch"
  mkdir out
  cd out
  "%civmain%\i5comp.exe" x "%civmain%\mgepatch\data1.cab"
  xcopy /S /C /H /R /Y "*.*" "%CivPath%\Civilization II Multiplayer Gold Edition"
)

cd \
pushd "%CIVMAIN%" || exit /b 1
if exist "%CivPath%\common\CIV2TOT.TXT" (
  "%civmain%\7z.exe" e "%civmain%\totpatch.7z" -o"%civmain%\totpatch" -y
  cd "%civmain%\totpatch"
  mkdir out
  cd out
  "%civmain%\i5comp.exe" x "%civmain%\totpatch\data1.cab"
  xcopy /S /C /H /R /Y "*.*" "%CivPath%\Test of Time"
)

cd \
pushd "%CIVMAIN%" || exit /b 1
if exist "%CivPath%\common\CIV2TOT.TXT" (
  "%civmain%\7z.exe" e "%civmain%\totTTP.7z" -o"%civmain%\totTTP" -y
  cd "%civmain%\totTTP"
  mkdir out
  cd out
  "%civmain%\i5comp.exe" x "%civmain%\totTTP\data1.cab"
  xcopy /S /C /H /R /Y "*.*" "%CivPath%\Test of Time"
  robocopy "%CivPath%\Test of Time\Somewhere in Time" "%CivPath%\Test of Time\Elsewhere in Time" /E /XC /XN /XO
  del "%CivPath%\Test of Time\Elsewhere in Time\Time.SCN"
)

goto END

:FULL
"%civmain%\7z.exe" e "%civmain%\Sid-Meiers-Civilization_Patch_Win-3x_EN.zip" -o"%CivPath%\CIVWIN" -y
rd /s /q "%CivPath%\CIVWIN\Civilization_Win_upgrade_v1.2"

"%civmain%\7z.exe" e "%civmain%\Sid-Meiers-CivNet_Patch_Win-3x_EN_Patch-13.zip" -o"%CivPath%\CIVNET" -y
rmdir "%CivPath%\CIVNET\Sid_Meiers_Civnet_patch_13"

"%civmain%\7z.exe" e "%civmain%\mgepatch.7z" -o"%civmain%\mgepatch" -y
cd "%civmain%\mgepatch"
mkdir out
cd out
"%civmain%\i5comp.exe" x "%civmain%\mgepatch\data1.cab"
xcopy /S /C /H /R /Y "*.*" "%CivPath%\Civilization II Multiplayer Gold Edition"

cd \
pushd "%CIVMAIN%" || exit /b 1
"%civmain%\7z.exe" e "%civmain%\totpatch.7z" -o"%civmain%\totpatch" -y
cd "%civmain%\totpatch"
mkdir out
cd out
"%civmain%\i5comp.exe" x "%civmain%\totpatch\data1.cab"
xcopy /S /C /H /R /Y "*.*" "%CivPath%\Test of Time"

cd \
pushd "%CIVMAIN%" || exit /b 1
"%civmain%\7z.exe" e "%civmain%\totTTP.7z" -o"%civmain%\totTTP" -y
cd "%civmain%\totTTP"
mkdir out
cd out
"%civmain%\i5comp.exe" x "%civmain%\totTTP\data1.cab"
xcopy /S /C /H /R /Y "*.*" "%CivPath%\Test of Time"
robocopy "%CivPath%\Test of Time\Somewhere in Time" "%CivPath%\Test of Time\Elsewhere in Time" /E /XC /XN /XO
del "%CivPath%\Test of Time\Elsewhere in Time\Time.SCN"

cd \
pushd "%CIVMAIN%" || exit /b 1
goto END

:END
if exist "%CivPath%\common\PATCH.TXT" goto QUIT
echo Done Installing Patches
timeout 10
exit /b 0

:QUIT
echo Upgrading Music.....
timeout 5
Powershell -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12"

if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/American%%20Revolution.mp3' -OutFile ""%CivPath%\Test of Time\Music\American Revolution.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Aristotle%%27s%%20Pupil.mp3' -OutFile ""%CivPath%\Test of Time\Music\Aristotle_s Pupil.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Augustus%%20Rises.mp3' -OutFile ""%CivPath%\Test of Time\Music\Augustus Rises.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Gautama%%20Ponders.mp3' -OutFile ""%CivPath%\Test of Time\Music\Gautama Ponders.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Hammurabi%%27s%%20Code.mp3' -OutFile ""%CivPath%\Test of Time\Music\Hammurabi_s Code.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Harvest%%20of%%20the%%20Nile.mp3' -OutFile ""%CivPath%\Test of Time\Music\Harvest of the Nile.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Jihad.mp3' -OutFile ""%CivPath%\Test of Time\Music\Jihad.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Tenochtitlan%%20Revealed.mp3' -OutFile ""%CivPath%\Test of Time\Music\Tenochtitlan Revealed.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Civil%%20War.mp3' -OutFile ""%CivPath%\Test of Time\Music\The Civil War.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Great%%20War.mp3' -OutFile ""%CivPath%\Test of Time\Music\The Great War.mp3"""
if exist "%CivPath%\Test of Time" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Shining%%20Path.mp3' -OutFile ""%CivPath%\Test of Time\Music\The Shining Path.mp3"""

if exist "%CivPath%\Test of Time" move /Y "%CivPath%\Test of Time\Music\Aristotle_s Pupil.mp3" "%CivPath%\Test of Time\Music\Aristotle's Pupil.mp3"
if exist "%CivPath%\Test of Time" move /Y "%CivPath%\Test of Time\Music\Hammurabi_s Code.mp3" "%CivPath%\Test of Time\Music\Hammurabi's Code.mp3"

if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/American%%20Revolution.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK12.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Aristotle%%27s%%20Pupil.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK13.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Augustus%%20Rises.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK14.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Gautama%%20Ponders.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK15.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Hammurabi%%27s%%20Code.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK16.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Harvest%%20of%%20the%%20Nile.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK17.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Jihad.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK18.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/Tenochtitlan%%20Revealed.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK19.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Civil%%20War.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK20.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Great%%20War.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK21.mp3"""
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" Powershell -Command "Invoke-WebRequest -Uri 'https://github.com/ProfGarfield/ExtendedMusicForTOTPP/raw/main/Music/The%%20Shining%%20Path.mp3' -OutFile ""%CivPath%\Civilization II Multiplayer Gold Edition\Music\TRACK22.mp3"""

if exist "%CivPath%\Civilization II Multiplayer Gold Edition" cd "%CivPath%\Civilization II Multiplayer Gold Edition\Music" && for %%i in (*.mp3) do "%LAME%" --decode "%%i" "%%~ni.wav"

echo Done Installing Patches...
timeout 10
exit /b 0
