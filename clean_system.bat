@echo off
setlocal enabledelayedexpansion

:: [STRATEGY] Auto-Admin Elevation Check
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo [ERROR] Please Run as Administrator!
    pause
    exit /b
)

title Advanced System Optimizer & Network Fixer
color 0B

echo ============================================================
echo      ADVANCED WINDOWS CLEANUP & NETWORK STABILITY TOOL
echo ============================================================
echo.

:: 1. Network & Internet Stability Fix (New Addition)
echo [+] Fixing Network Stability & Resetting Stack...
ipconfig /release >nul 2>&1
ipconfig /renew >nul 2>&1
ipconfig /flushdns >nul 2>&1
netsh winsock reset >nul 2>&1
netsh int ip reset >nul 2>&1
netsh interface set interface name="Wi-Fi" admin=disabled >nul 2>&1
netsh interface set interface name="Wi-Fi" admin=enabled >nul 2>&1
netsh interface set interface name="Ethernet" admin=disabled >nul 2>&1
netsh interface set interface name="Ethernet" admin=enabled >nul 2>&1
echo [✔] Network Stack Reset Complete.

:: 2. System Junk Cleaning
echo [+] Cleaning System Junk & Temp Files...
[cite_start]del /s /f /q %temp%\* [cite: 1]
[cite_start]del /s /f /q C:\Windows\Temp\* [cite: 1]
[cite_start]del /s /f /q C:\Windows\Prefetch\* [cite: 1]

:: 3. Thumbnail Cache
echo [+] Clearing Thumbnail Cache...
[cite_start]del /s /f /q "%LOCALAPPDATA%\Microsoft\Windows\Explorer\thumbcache*.db" [cite: 1]

:: 4. Windows Update Cache
echo [+] Cleaning SoftwareDistribution (Update Cache)...
[cite_start]net stop wuauserv >nul 2>&1 [cite: 1]
[cite_start]net stop bits >nul 2>&1 [cite: 1]
[cite_start]del /s /f /q C:\Windows\SoftwareDistribution\* [cite: 1]
[cite_start]net start wuauserv >nul 2>&1 [cite: 1]
[cite_start]net start bits >nul 2>&1 [cite: 1]

:: 5. Power Cleaning (Recycle Bin & Logs)
echo [+] Emptying Recycle Bin...
[cite_start]PowerShell.exe -Command "Clear-RecycleBin -Confirm:$false" [cite: 1]
echo [+] Cleaning System Logs...
[cite_start]for /f "tokens=*" %%G in ('wevtutil el') do wevtutil cl "%%G" [cite: 2]

:: 6. Service Refresh
echo [+] Refreshing Superfetch (SysMain)...
[cite_start]net stop sysmain >nul 2>&1 [cite: 2]
[cite_start]net start sysmain >nul 2>&1 [cite: 2]

echo.
echo ------------------------------------------------------------
[cite_start]echo SYSTEM CLEANED & NETWORK STABILIZED SUCCESSFULLY ✔ [cite: 3]
echo ------------------------------------------------------------
pause
