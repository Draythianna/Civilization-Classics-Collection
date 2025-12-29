@echo off
setlocal EnableExtensions EnableDelayedExpansion

REM ===============================================
REM Civilization Classics Collection - extract.bat
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
cls

cd "%civmain%"
set drive=
cls
if exist "%CivPath%\common\FULL.TXT" goto civ1
if exist "%CivPath%\common\CIV1.TXT" goto civ1
if exist "%CivPath%\common\CIVNET.TXT" goto civnet
if exist "%CivPath%\common\CIV2MGE.TXT" goto civmge
if exist "%CivPath%\common\CIV2TOT.TXT" goto civtot
goto final

:civ1
echo Sid Meier's Civilization 1 Extractor...
set drive=%Civ1Data%
for %%i in (%drive%) do if %%~xi==.zip goto civd
for %%i in (%drive%) do if %%~xi==.rar goto civd
for %%i in (%drive%) do if %%~xi==.7z.exe goto civd
set drive=%Civ1Drive%
if exist %drive%\Setup.exe goto civc
goto civa

:civb
set CDBIN=%drive%
echo %drive%
set CDCUE=
for %%i in (%drive%) do set CDCUE=%%~dpni.cue
cd /
mkdir "%CivPath%\CIVWIN"
cd "%CivPath%\CIVWIN"
mkdir TMP
cd TMP
%civmain%\bchunk.v1.2.1_repub.1.exe -w "%CDBIN%" "%CDCUE%" TRACK
for %%i in (*.wav) do %civmain%\%lame%-b 320 -h %%i %%~ni.mp3
echo A | %civmain%\7z.exe x TRACK01.iso
echo A | %civmain%\7z.exe x "%drive%"
cd CivWin3.1
SETUP.EXE
cd ..
echo A | xcopy /S /C /H /R /Y C:\mps\CIVWIN\*.* ..\
rd /S /Q C:\mps\CIVWIN
rmdir C:\mps
%civmain%\I5comp.exe x data1.cab
cd ..
rd /S /Q "%CivPath%\CIVWIN\TMP\CivWin3.1"
rd /s /q "%CivPath%\CIVWIN\TMP"
echo Civ1 Installed....
timeout 5
if exist "%CivPath%\common\FULL.TXT" goto civnet
if exist "%CivPath%\common\CIVNET.TXT" goto civnet
if exist "%CivPath%\common\CIV2MGE.TXT" goto civmge
if exist "%CivPath%\common\CIV2TOT.TXT" goto civtot
goto final

:civa
set drive=%Civ1ISO%
echo %drive%
cd %drive%
echo A | xcopy /S /C /H /R /Y *.* "%CivPath%\CIVWIN\tmp"
%drive%\SETUP.EXE
mkdir "%CivPath%\CIVWIN"
cd "%CivPath%\CIVWIN"
echo A | xcopy /S /C /H /R /Y C:\mps\CIVWIN\*.* .
rd /S /Q C:\mps\CIVWIN
rmdir C:\mps
rmdir "%CivPath%\CIVWIN\CivWin3.1"
echo Civ1 Installed...
timeout 5
if exist "%CivPath%\common\FULL.TXT" goto civnet
if exist "%CivPath%\common\CIVNET.TXT" goto civnet
if exist "%CivPath%\common\CIV2MGE.TXT" goto civmge
if exist "%CivPath%\common\CIV2TOT.TXT" goto civtot
goto final

:civc
set drive=%Civ1Drive%
goto civb

:civd
set drive=%Civ1Data%
goto civb

:civnet
echo Sid Meier's CivNet Extractor...
set drive=%CivNetData%
for %%i in (%drive%) do if %%~xi==.zip goto civnc
for %%i in (%drive%) do if %%~xi==.rar goto civnc
for %%i in (%drive%) do if %%~xi==.7z.exe goto civnc
set drive=%CivNetDrive%
if exist %drive%\INSTALL.exe goto civna
goto civnd

:civnb
cd \
mkdir "%CivPath%\CIVNET"
cd "%CivPath%\CIVNET"
mkdir TMP
cd TMP
%civmain%\bchunk.v1.2.1_repub.1.exe -w "%CDBIN%" "%CDCUE%" TRACK
for %%i in (*.wav) do %civmain%\%lame%-b 320 -h %%i %%~ni.mp3
mkdir ..\Music
move *.wav ..\Music
echo A | %civmain%\7z.exe x TRACK01.iso
echo A | %civmain%\7z.exe x "%drive%"
echo A | xcopy /S /C /H /R /Y CIVGUIDE ../
echo A | xcopy /S /C /H /R /Y INTERNET ../
INSTALL.exe
cd ..
echo A | xcopy /S /C /H /R /Y C:\mps\CIVNET\*.* .
rd /S /Q C:\mps\CIVNET
rmdir C:\mps
%civmain%\I5comp.exe x TMP\data1.cab
mkdir Music
mkdir Sound
move TMP\*.wav Sound\
move TMP\*.mp3 Music\
rd /S /Q TMP
echo CivNet Installed...
timeout 5
if exist "%CivPath%\common\FULL.TXT" goto civmge
if exist "%CivPath%\common\CIV2MGE.TXT" goto civmge
if exist "%CivPath%\common\CIV2TOT.TXT" goto civtot
goto final

:civna
cd \
set drive=%CivNetDrive%
cd %drive%
INSTALL.exe
mkdir "%CivPath%\CIVNET"
echo A | xcopy /S /C /H /R /Y C:\mps\CIVNET\*.* "%CivPath%\CIVNET\"
echo A | xcopy /S /C /H /R /Y "%drive%\CIVGUIDE" "%CivPath%\CIVNET\CIVGUIDE"
echo A | xcopy /S /C /H /R /Y "%drive%\INTERNET" "%CivPath%\CIVNET\INTERNET"
rd /S /Q C:\mps\CIVNET
rmdir C:\mps
echo CivNet Installed...
timeout 5
if exist "%CivPath%\common\FULL.TXT" goto civmge
if exist "%CivPath%\common\CIV2MGE.TXT" goto civmge
if exist "%CivPath%\common\CIV2TOT.TXT" goto civtot
goto final

:civnc
cd \
set drive=%CivNetData%
set CDBIN=%drive%
echo %drive%
set CDCUE=
for %%i in (%drive%) do set CDCUE=%%~dpni.cue
goto civnb

:civnd
cd \
set drive=%CivNetISO%
set CDBIN=%drive%
echo %drive%
set CDCUE=
for %%i in (%drive%) do set CDCUE=%%~dpni.cue
goto civnb

:civmge
echo Sid Meier's Civilization II Multiplayer Gold Edition Extractor...
set drive=%Civ2Data%
for %%i in (%drive%) do if %%~xi==.zip goto civ2d
for %%i in (%drive%) do if %%~xi==.rar goto civ2d
for %%i in (%drive%) do if %%~xi==.7z.exe goto civ2d
set drive=%Civ2Drive%
if exist %drive%\Setup.exe goto civ2a
goto civ2c

:civ2b
set CDBIN=%drive%
echo %drive%
for %%i in (%drive%) do set CDCUE=%%~dpni.cue
cd /
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition"
cd "%CivPath%\Civilization II Multiplayer Gold Edition"
mkdir TMP
cd TMP
%civmain%\bchunk.v1.2.1_repub.1.exe -w "%CDBIN%" "%CDCUE%" TRACK
ren TRACK*.wav TRACK*.wav2
move TRACK02.wav2 TRACK01.wav
move TRACK03.wav2 TRACK02.wav
move TRACK04.wav2 TRACK03.wav
move TRACK05.wav2 TRACK04.wav
move TRACK06.wav2 TRACK05.wav
move TRACK07.wav2 TRACK06.wav
move TRACK08.wav2 TRACK07.wav
move TRACK09.wav2 TRACK08.wav
move TRACK10.wav2 TRACK09.wav
move TRACK11.wav2 TRACK10.wav
move TRACK12.wav2 TRACK11.wav
for %%i in (*.wav) do %civmain%\%lame%-b 320 -h %%i %%~ni.mp3
mkdir ..\Music
move *.wav ..\Music
echo A | %civmain%\7z.exe x TRACK01.iso
cd ..
%civmain%\I5comp.exe x TMP\data1.cab
move TMP\*.mp3 Music\
mkdir VIDEO
echo A | xcopy /S /C /H /R /Y TMP\Civ2\VIDEO\*.* VIDEO\
mkdir KINGS
echo A | xcopy /S /C /H /R /Y TMP\Civ2\KINGS\*.* KINGS\
rd /S /Q TMP
mkdir Sound
move *.wav Sound\
echo Civ2MGE Installed...
timeout 5
if exist "%CivPath%\common\FULL.TXT" goto civtot
if exist "%CivPath%\common\CIV2TOT.TXT" goto civtot
goto final

:civ2a
set drive=%Civ2Drive%
echo %drive%
cd %drive%
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition"
mkdir "%CivPath%\Civilization II Multiplayer Gold Edition\TMP"
echo A | xcopy /S /C /H /R /Y *.* "%CivPath%\Civilization II Multiplayer Gold Edition\TMP"
goto civ2b

:civ2c
set drive=%Civ2ISO%
goto civ2b

:civ2d
set drive=%Civ2Data%
goto civ2b

:civtot
echo Sid Meier's Civilization Test of Time Extractor...
set drive=%CivToTData%
for %%i in (%drive%) do if %%~xi==.zip goto civtd
for %%i in (%drive%) do if %%~xi==.rar goto civtd
for %%i in (%drive%) do if %%~xi==.7z.exe goto civtd
set drive=%CivToTDrive%
if exist %drive%\Setup.exe goto civta
goto civtc

:civtb
set CDBIN=%drive%
echo %drive%
for %%i in (%drive%) do set CDCUE=%%~dpni.cue
cd /
mkdir "%CivPath%\Test of Time"
cd "%CivPath%\Test of Time"
mkdir TMP
cd TMP
%civmain%\bchunk.v1.2.1_repub.1.exe -w "%CDBIN%" "%CDCUE%" TRACK
for %%i in (*.wav) do %civmain%\%lame%-b 320 -h %%i %%~ni.mp3
del TRACK*.wav
echo A | %civmain%\7z.exe x TRACK01.iso
cd ..
%civmain%\I5comp.exe x TMP\data1.cab
mkdir Music
move TMP\*.wav Music\
move TMP\*.mp3 Music\
mkdir VIDEO
echo A | xcopy /S /C /H /R /Y TMP\Civ2\VIDEO\*.* VIDEO\
move Music\TRACK02.mp3 "Music\Funeral March.mp3"
move Music\TRACK03.mp3 "Music\Ode To Joy.mp3"
move Music\TRACK04.mp3 "Music\Crusade.mp3"
move Music\TRACK05.mp3 "Music\Alien.mp3"
move Music\TRACK06.mp3 "Music\Mongol Horde.mp3"
move Music\TRACK07.mp3 "Music\The Apocalypse.mp3"
move Music\TRACK08.mp3 "Music\Jurassic Jungle.mp3"
move Music\TRACK09.mp3 "Music\New World.mp3"
move Music\TRACK10.mp3 "Music\Tolkien.mp3"
move Music\TRACK11.mp3 "Music\Mars Expedition.mp3"
move Music\TRACK12.mp3 "Music\Jules Verne.mp3"
move Music\TRACK13.mp3 "Music\They're Here.mp3"
move Music\TRACK14.mp3 "Music\The Dome.mp3"
rd /S /Q TMP
echo CivToT Installed...
timeout 5
goto final

:civta
set drive=%CivToTDrive%
cd %drive%
mkdir "%CivPath%\Test of Time"
mkdir "%CivPath%\Test of Time\TMP"
echo A | xcopy /S /C /H /R /Y *.* "%CivPath%\Test of Time\TMP"
goto civtb

:civtc
set drive=%CivToTISO%
goto civtb

:civtd
set drive=%CivToTData%
goto civtb

:final
if exist "%CivPath%\Civilization II Multiplayer Gold Edition" cd "%CivPath%\Civilization II Multiplayer Gold Edition\Music" && for %%i in (*.mp3) do "%lame%" --decode "%%i" "%%~ni.wav"

cd /
cd "%civmain%"
echo Extraction done...
timeout 10
exit /b 0
