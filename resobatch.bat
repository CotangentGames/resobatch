@echo off
setlocal EnableDelayedExpansion

if not defined RESOBATCH_ACTIVE (
    echo This file can only be called, not executed directly.
    pause
    exit /b
)

set /a number=%random% %% 100
set "file=%~1"
set "tempFile=%temp%\ResoBatch_%RANDOM%_%TIME::=%.vbs"

if not exist "%file%" (
    echo Attempted to play a nonexistent file.
    pause
    exit /b
)

(
echo Set Sound = CreateObject("WMPlayer.OCX.7"^)
echo Sound.URL = "%file%"
echo Sound.Controls.play
echo Do While Sound.playState ^<^> 1
echo     WScript.Sleep 100
echo Loop
echo Set fso = CreateObject("Scripting.FileSystemObject"^)
echo fso.DeleteFile WScript.ScriptFullName
) > "%tempFile%"

start "" /min wscript.exe "%tempFile%"
