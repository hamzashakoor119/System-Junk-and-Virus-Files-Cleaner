@echo off
setlocal enabledelayedexpansion

:: [STRATEGY] Auto-Admin Elevation Check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please Run as Administrator!
    pause
    exit /b
)

title Advanced System Optimizer v2.0
color 0B

echo ============================================================
echo           ADVANCED WINDOWS CLEANUP TOOL 
echo ============================================================
echo.

:: 1. System Junk Cleaning
echo [+] Cleaning System Junk & Temp Files... 
del /s /f /q %temp%\* 
del /s /f /q C:\Windows\Temp\* 
del /s /f /q C:\Windows\Prefetch\* 

:: 2. Thumbnail Cache
echo [+] Clearing Thumbnail Cache... 
del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*.db" 

:: 3. Network Optimization
echo [+] Flushing DNS Cache... 
ipconfig /flushdns 

:: 4. Windows Update Cache (Expert Level)
echo [+] Cleaning SoftwareDistribution (Update Cache)... 
net stop wuauserv >nul 2>&1 
net stop bits >nul 2>&1 
del /s /f /q C:\Windows\SoftwareDistribution\* 
net start wuauserv >nul 2>&1 
net start bits >nul 2>&1 

:: 5. Specialized Cleanup
echo [+] Clearing Delivery Optimization... 
del /s /f /q C:\Windows\SoftwareDistribution\DeliveryOptimization\* 
echo [+] Resetting Windows Store Cache... 
wsreset.exe 

:: 6. Power Cleaning (Recycle Bin & Logs)
echo [+] Emptying Recycle Bin... 
PowerShell.exe -Command "Clear-RecycleBin -Confirm:$false" 
echo [+] Cleaning Windows Error Reports... 
del /s /f /q C:\ProgramData\Microsoft\Windows\WER\* 
echo [+] Clearing System Logs... [cite: 2]
for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G" [cite: 2]

:: 7. UI Optimization
echo [+] Removing Broken Desktop Shortcuts... 
for %%i in ("%USERPROFILE%\Desktop\*.lnk") do (
    if not exist "%%~fi" del "%%i" 
)

:: 8. Service Refresh
echo [+] Refreshing Superfetch... 
net stop sysmain >nul 2>&1
net start sysmain >nul 2>&1 

echo.
echo ------------------------------------------------------------
echo [cite: 3] SYSTEM CLEANED SUCCESSFULLY ✔ [cite: 3]
echo ------------------------------------------------------------
pause