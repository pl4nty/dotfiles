# winget export packages.json
winget import winget.json
Write-Warning "Install personal packages, or press S to skip" -WarningAction Inquire
winget import winget-personal.json

oh-my-posh font install --user FiraCode
mklink $PROFILE Microsoft.PowerShell_profile.ps1

mklink $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json terminal.json
