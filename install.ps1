
# Power mode to performance
# Windows Updates
# Upgrade SKU if needed
# Update store apps
# Create 32GB Dev Drive

[CmdletBinding(SupportsShouldProcess)]
param()

# winget export packages.json
winget import winget.json --accept-source-agreements --accept-package-agreements
if ($PSCmdlet.ShouldContinue("personal packages?", "winget import")) {
  winget import winget-personal.json --accept-source-agreements --accept-package-agreements
}

New-Item -ItemType HardLink $HOME\.wslconfig -Target .wslconfig
wsl --install --no-distribution

mkdir D:\repos
"PowerShell", "WindowsPowerShell" | ForEach-Object {
  $packages = Join-Path ([Environment]::GetFolderPath("MyDocuments")) $_
  mkdir D:\packages\$_
  New-Item -ItemType Junction $packages -Target D:\packages\$_
  # can't link files (hard or symlink) across drives yet
  Copy-Item Microsoft.PowerShell_profile.ps1 $packages\Microsoft.PowerShell_profile.ps1
}
Set-PackageSource PSGallery -Trusted
pwsh -Command {
  Set-PackageSource PSGallery -Trusted
}

oh-my-posh font install --user FiraCode

New-Item -ItemType HardLink $env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json -Target terminal.json

Get-Item *.gitconfig | ForEach-Object {
  New-Item -ItemType HardLink (Join-Path $HOME $_.Name) -Target $_.Name
}

Start-Process custom.deskthemepack

# Extend monitor
# Set language
# Set lock screen
# Taskbar - Explorer, Terminal, Edge, VSCode
# Unpin/uninstall start menu
# Alt-tab don't show app tabs
# Clipboard history
# Hide desktop icons
# Explorer show file extensions and hidden files
# Sign in to Bitwarden and GitHub
# VSCode sync settings with GitHub
# Edge search engine and sidebar
