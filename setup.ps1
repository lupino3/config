# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
if (-not (Test-Path ~\.gitconfig)) {
    Write-Output "Copying .gitconfig"
    Copy-Item $PSScriptRoot\.gitconfig ~
}

# Install software. Use a very hacky sentinel file to skip if not needed.
# Install the updated Windows Package Manager from https://github.com/microsoft/winget-cli/releases before running this section.
if (-not (Test-Path $PSScriptRoot\.installed)) {
    winget install git
    winget install Microsoft.VisualStudioCode.User-x64
    winget install Microsoft.VisualStudio.Enterprise
    winget install Microsoft.WindowsTerminal
    # winget install Microsoft.Office (the installer doesn't seem to be working)
    Set-Content $PSScriptRoot\.installed "yo"
}

if (-Not (Test-Path ~\.local_gitconfig)) {
    Copy-Item $PSScriptRoot\.local_gitconfig_template ~\.local_gitconfig
    code ~\.local_gitconfig
    Write-Output "Please edit ~/.local_gitconfig, adding the [user] stanza (name, email)"
}

# From https://www.hanselman.com/blog/how-to-make-a-pretty-prompt-in-windows-terminal-with-powerline-nerd-fonts-cascadia-code-wsl-and-ohmyposh
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name PSReadLine -Scope CurrentUser -Force -SkipPublisherCheck

if (-Not (Test-Path $PROFILE)) {
    Copy-Item profile-template.ps1 $PROFILE
} else {
    Write-Output "$PROFILE exists. Check if the contents have the commands in profile-template.ps1"
}

Write-Output "Install Cascadia Code PL and set it as the font for Windows Terminal"