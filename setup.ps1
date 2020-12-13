# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
if (-not (Test-Path ~\.gitconfig)) {
    echo "Copying .gitconfig"
    cp $PSScriptRoot\.gitconfig ~
}

if (-Not (Test-Path ~\.local_gitconfig)) {
    cp $PSScriptRoot\.local_gitconfig_template ~\.local_gitconfig
    code ~\.local_gitconfig
    echo "Please edit ~/.local_gitconfig, adding the [user] stanza (name, email)"
}

# From https://www.hanselman.com/blog/how-to-make-a-pretty-prompt-in-windows-terminal-with-powerline-nerd-fonts-cascadia-code-wsl-and-ohmyposh
Install-Module posh-git -Scope CurrentUser
Install-Module oh-my-posh -Scope CurrentUser
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck

if (-Not (Test-Path $PROFILE)) {
    cp profile-template.ps1 $PROFILE
} else {
    echo "$PROFILE exists. Check if the contents have the commands in profile-template.ps1"
}

echo "Install Cascadia Code PL and set it as the font for Windows Terminal"