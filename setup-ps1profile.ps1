# Install posh-git

Write-Host "Installing posh-git.."
Install-Module posh-git -Scope CurrentUser -AllowPrerelease -Force
Write-Host "Adding posh-git to PS1 profile.."
Add-PoshGitToProfile -AllHosts
