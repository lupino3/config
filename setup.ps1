# Set-ExecutionPolicy -Scope CurrentUser RemoteSigned
cp $PSScriptRoot\.gitconfig ~
cp $PSScriptRoot\.local_gitconfig_template ~\.local_gitconfig
code ~\.local_gitconfig
echo "Please edit ~/.local_gitconfig, adding the [user] stanza (name, email)"
