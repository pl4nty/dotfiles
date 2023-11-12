# winget export packages.json
winget import winget.json
Write-Warning "Install personal packages, or press S to skip" -WarningAction Inquire
winget import winget-personal.json

oh-my-posh font install --user FiraCode
New-Item -ItemType SymbolicLink $PROFILE -Target Microsoft.PowerShell_profile.ps1

New-Item -ItemType SymbolicLink $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Target terminal.json
