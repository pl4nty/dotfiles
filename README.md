# dotfiles

Config files for Linux and Windows.

## Windows

OS config is often manual and difficult to track, so isn't included. Let me know if you have a good way to do this!

I use the [Windows Package Manager](https://learn.microsoft.com/en-us/windows/package-manager/) to install and update apps.
[PowerShell Core](https://github.com/PowerShell/PowerShell) is my primary shell, with [Windows Terminal](https://github.com/microsoft/terminal) for multiplexing and [Oh My Posh](https://github.com/jandedobbeleer/oh-my-posh) for cross-platform theming. [Fira Code](https://github.com/tonsky/FiraCode) with ligatures has been my day-to-day font since my first IDE. [Commit Mono](https://commitmono.com/) and [Monaspace](https://github.com/githubnext/monaspace) are exciting though.

## Linux

Only accessed remotely (SSH, VSCode Server, dev containers), so just shell config with [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh) and [Oh My Posh](https://github.com/jandedobbeleer/oh-my-posh). Project-specific config is usually managed via dev containers so I can [install my dotfiles automatically](https://code.visualstudio.com/docs/devcontainers/containers#_personalizing-with-dotfile-repositories).

## Usage

```PowerShell
winget install Git.Git
$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
git clone https://github.com/pl4nty/dotfiles; cd dotfiles
Set-ExecutionPolicy Bypass -Scope CurrentUser
.\install.ps1
```

```bash
./install.sh
```
