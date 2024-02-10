[CmdletBinding(SupportsShouldProcess)]
param()

start custom.deskthemepack

# winget export packages.json
winget import winget.json --accept-source-agreements --accept-package-agreements
if ($PSCmdlet.ShouldContinue("personal packages?", "winget import")) {
  winget import winget-personal.json --accept-source-agreements --accept-package-agreements
}

oh-my-posh font install --user FiraCode
New-Item -ItemType HardLink $PROFILE -Target Microsoft.PowerShell_profile.ps1

New-Item -ItemType HardLink $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Target terminal.json

Get-Item *.gitconfig | ForEach-Object {
  New-Item -ItemType HardLink (Join-Path $HOME $_.Name) -Target $_.Name
}
