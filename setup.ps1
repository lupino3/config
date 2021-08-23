# TODO: this file should be self-sufficient (no dependencies on external files) so I can just download it and run it.
# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
if (-not (Test-Path ~\.gitconfig)) {
    Write-Output "Copying .gitconfig"
    Copy-Item $PSScriptRoot\.gitconfig ~
}

# Disable Edge windows in alt-tab
Set-ItemProperty  -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced\' -Name MultiTaskingAltTabFilter -Value 3

# Install software. Use a very hacky sentinel file to skip if not needed.
# Install the updated Windows Package Manager from https://github.com/microsoft/winget-cli/releases before running this section.
# TODO: use winget import JSON file.
if (-not (Test-Path $PSScriptRoot\.installed)) {
    winget install git
    winget install Microsoft.VisualStudioCode.User-x64
    winget install Microsoft.VisualStudio.Enterprise
    winget install Microsoft.WindowsTerminal
    winget install Google.Chrome
    winget install Microsoft.Powershell
    # winget install Microsoft.Office (the installer doesn't seem to be working)
    Set-Content $PSScriptRoot\.installed "yo"
}

if (-Not (Test-Path ~\.local_gitconfig)) {
    Copy-Item $PSScriptRoot\.local_gitconfig_template ~\.local_gitconfig
    code ~\.local_gitconfig
    Write-Output "Please edit ~/.local_gitconfig, adding the [user] stanza (name, email)"
}

if (-Not (Test-Path ~\.ssh\id_rsa)) {
    Write-Output "Generating a public key for GitHub. Set a non-empty passphrase."
    ssh-keygen
}

Install-Module oh-my-posh -Scope CurrentUser

if (-Not (Test-Path $PROFILE)) {
    Copy-Item profile-template.ps1 $PROFILE
} else {
    Write-Output "$PROFILE exists. Check if the contents have the commands in profile-template.ps1"
}

Write-Output "Install FiraCode Nerd Font and set it as the font for Windows Terminal"
Write-Output '"fontFace": "FiraMono Nerd Font"'
Write-Output "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip"
