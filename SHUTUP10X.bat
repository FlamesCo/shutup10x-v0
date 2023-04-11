@echo off

REM Check if running with administrator privileges.
net session >nul 2>&1 || (
    echo Please run this script as Administrator.
    pause
    exit /b 1
)

REM Enable execution of unsigned scripts temporarily,
powershell.exe -Command "Set-ExecutionPolicy Unrestricted -Scope Process"

REM Removing traces of installed Edge versions (Stable, Beta, Dev).
powershell.exe -Command "Get-AppxPackage *MicrosoftEdge* | Remove-AppxPackage"
for %%G in ("%ProgramFiles(x86)%\Microsoft\Edge", "%ProgramFiles%\Microsoft\Edge") do rd /s/q "%%~G\Application" 

REG DELETE HKLM\System\FNTCACHE.DAT 
reg add HKEY_LOCAL_MACHINE \ SOFTWARE \ Policies \ Microsoft \ CloudExperienceHost / v DisableWindowsConsumerFeaturesOnDomainJoinedDevices/t REG_DWORD/d 0/f  
ECHO Successfully removed! Restarting Explorer...
taskkill IM explorer.exe F && start explorer.exe```
