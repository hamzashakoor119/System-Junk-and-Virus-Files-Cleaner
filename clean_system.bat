@echo off
echo ===========================================
echo      ADVANCED WINDOWS CLEANUP TOOL
echo ===========================================

echo Cleaning System Junk Files...
echo -------------------------------

:: Delete Temp Files
del /s /f /q %temp%\*
del /s /f /q C:\Windows\Temp\*
del /s /f /q C:\Windows\Prefetch\*

:: Clear Thumbnail Cache
echo Clearing Thumbnail Cache...
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*.db"

:: Flush DNS
ipconfig /flushdns

:: Clean Software Distribution (Windows Update Cache)
echo Cleaning SoftwareDistribution...
net stop wuauserv
net stop bits
del /s /f /q C:\Windows\SoftwareDistribution\*
net start wuauserv
net start bits

:: Clear Delivery Optimization
echo Clearing Delivery Optimization Cache...
del /s /f /q C:\Windows\SoftwareDistribution\DeliveryOptimization\*

:: Clear Windows Store Cache
wsreset.exe

:: Empty Recycle Bin
PowerShell.exe -Command "Clear-RecycleBin -Confirm:$false"

:: Clear Windows Error Reports
echo Cleaning Windows Error Reports...
del /s /f /q C:\ProgramData\Microsoft\Windows\WER\*

:: Clear old Windows logs
echo Clearing Windows Log Files...
for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G"

:: Remove orphaned shortcuts from Desktop
echo Removing broken shortcuts...
for %%i in ("%USERPROFILE%\Desktop\*.lnk") do (
    if not exist "%%~fi" del "%%i"
)

:: Refresh Superfetch
net stop superfetch
net start superfetch

echo --------------------------------------
echo DONE! SYSTEM CLEANED SUCCESSFULLY ✔
echo --------------------------------------
pause
