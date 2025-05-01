@echo off
:: Set color for the console
color 0A

:: Function to display a loading screen
:loadingScreen
cls
echo.
echo ================================
echo      Privacy Optimization
echo ================================
echo.
echo Please wait while we optimize your privacy settings...
echo.
echo Loading...
for /L %%i in (1,1,10) do (
    set /p "=." <nul
    timeout /t 1 >nul
)
echo.
echo ================================
echo.

:: Function to display progress
:progress
setlocal enabledelayedexpansion
set "totalSteps=%1"
set "currentStep=0"
set "stepMessage=%2"

:loop
set /a currentStep+=1
set /a percent=(currentStep*100)/totalSteps
set "progressBar="
for /L %%i in (1,1,!percent!) do set "progressBar=!progressBar!█"
set "spaces=                                                                 "
set "spaces=!spaces:~0,100-!percent!!"
set "progress=!progressBar!!spaces!"
echo [!progress!] !percent!%% - !stepMessage!
if !currentStep! lss !totalSteps! (
    timeout /t 1 >nul
    goto loop
)
endlocal
echo.

:: Function to create a system restore point
:createRestorePoint
echo Creating a system restore point...
powershell -command "Checkpoint-Computer -Description 'Pre-Privacy Optimization' -RestorePointType 'MODIFY_SETTINGS'"
if %errorlevel% neq 0 (
    echo Failed to create a restore point. Continuing with optimization...
) else (
    echo Restore point created successfully.
)
echo.

:: Start loading screen
call :loadingScreen

:: Create a system restore point
call :createRestorePoint

:: Disable Telemetry
call :progress 1 "Disabling Telemetry"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

:: Disable Advertising ID
call :progress 1 "Disabling Advertising ID"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f

:: Disable Location Services
call :progress 1 "Disabling Location Services"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "State" /t REG_DWORD /d 0 /f

:: Disable Cortana
call :progress 1 "Disabling Cortana"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Windows Search" /v "AllowCortana" /t REG_DWORD /d 0 /f

:: Disable Background Apps
call :progress 1 "Disabling Background Apps"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications" /v "GlobalUserDisabled" /t REG_DWORD /d 1 /f

:: Disable Sync Settings
call :progress 1 "Disabling Sync Settings"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\SettingSync" /v "SyncSettings" /t REG_DWORD /d 0 /f

:: Disable Windows Ink Workspace
call :progress 1 "Disabling Windows Ink Workspace"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PenWorkspace" /v "Enabled" /t REG_DWORD /d 0 /f

:: Disable Windows Error Reporting
call :progress 1 "Disabling Windows Error Reporting"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f

:: Disable Microsoft Compatibility Telemetry
call :progress 1 "Disabling Microsoft Compatibility Telemetry"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "AllowTelemetry" /t REG_DWORD /d 0 /f

:: Disable Feedback Notifications
call :progress 1 "Disabling Feedback Notifications"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "FeedbackFrequency" /t REG_DWORD /d 0 /f

:: Disable Windows Store Apps from running in the background
call :progress 1 "Disabling Windows Store Apps"
for /f "tokens=*" %%a in ('powershell -command "Get-Appx
Package | Select-Object -ExpandProperty Name"') do (
    powershell -command "Get-AppxPackage %%a | Remove-AppxPackage"
)

:: Disable Windows Search Indexing
call :progress 1 "Disabling Windows Search Indexing"
sc config "WSearch" start= disabled
net stop "WSearch"

:: Disable OneDrive
call :progress 1 "Disabling OneDrive"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\OneDrive" /v "DisableFileSyncNGSC" /t REG_DWORD /d 1 /f

:: Disable Microsoft Edge Sync
call :progress 1 "Disabling Microsoft Edge Sync"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Edge" /v "SyncDisabled" /t REG_DWORD /d 1 /f

:: Disable Windows Defender Cloud Protection
call :progress 1 "Disabling Windows Defender Cloud Protection"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Cloud" /v "CloudBlockLevel" /t REG_DWORD /d 0 /f

:: Disable Windows Defender Real-time Protection
call :progress 1 "Disabling Windows Defender Real-time Protection"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows Defender\Real-Time Protection" /v "DisableRealtimeMonitoring" /t REG_DWORD /d 1 /f

:: Disable SmartScreen Filter
call :progress 1 "Disabling SmartScreen Filter"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SmartScreen" /v "Enabled" /t REG_DWORD /d 0 /f

:: Disable User Account Control (UAC)
call :progress 1 "Disabling User Account Control (UAC)"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /v "EnableLUA" /t REG_DWORD /d 0 /f

:: Disable Windows Update Delivery Optimization
call :progress 1 "Disabling Windows Update Delivery Optimization"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\DeliveryOptimization" /v "DODownloadMode" /t REG_DWORD /d 0 /f

:: Disable Windows Search Suggestions
call :progress 1 "Disabling Windows Search Suggestions"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f

:: Disable Windows Store
call :progress 1 "Disabling Windows Store"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "RemoveWindowsStore" /t REG_DWORD /d 1 /f

:: Disable Windows Feedback Hub
call :progress 1 "Disabling Windows Feedback Hub"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\Feedback" /v "DisableFeedback" /t REG_DWORD /d 1 /f

:: Disable Windows Media Player
call :progress 1 "Disabling Windows Media Player"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\MediaPlayer" /v "DisableMediaPlayer" /t REG_DWORD /d 1 /f

:: Disable Windows Game Bar
call :progress 1 "Disabling Windows Game Bar"
reg add "HKEY_CURRENT_USER\Software\Microsoft\GameBar" /v "AllowAutoGameMode" /t REG_DWORD /d 0 /f

:: Disable Windows Store Automatic Updates
call :progress 1 "Disabling Windows Store Automatic Updates"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\WindowsStore" /v "AutoUpdate" /t REG_DWORD /d 0 /f

:: Disable Windows 11 Widgets
call :progress 1 "Disabling Windows 11 Widgets"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer" /v "NoWidgets" /t REG_DWORD /d 1 /f

:: Disable Microsoft Account Sign-in
call :progress 1 "Disabling Microsoft Account Sign-in"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Authentication\LogonUI" /v "DisableMicrosoftAccount" /t REG_DWORD /d 1 /f

:: Disable Windows 11 Notifications
call :progress 1 "Disabling Windows 11 Notifications"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\PushNotifications" /v "ToastEnabled" /t REG_DWORD /d 0 /f

:: Disable Windows 11 App Suggestions
call :progress 1 "Disabling App Suggestions"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "ShowAppsSuggestions" /t REG_DWORD /d 0 /f

:: Disable Windows 11 Search History
call :progress 1 "Disabling Search History"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchHistoryEnabled" /t REG_DWORD /d 0 /f

:: Disable Windows 11 Location History
call :progress 1 "Disabling Location History"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\location" /v "State" /t REG_DWORD /d 0 /f

:: Disable Windows 11 Camera and Microphone Access
call :progress 1 "Disabling Camera and Microphone Access"
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\webcam" /v "State" /t REG_DWORD /d 0 /f
reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "State" /t REG_DWORD /d 0 /f

:: Disable Windows 11 Automatic Updates
call :progress 1 "Disabling Automatic Updates"
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v "NoAutoUpdate" /t REG_DWORD /d 1 /f

:: Final message
echo.
echo ================================
echo      Optimization Complete!
echo ================================
echo All privacy settings have been optimized.
echo Please restart your computer for all changes to take effect.
pause
exit

