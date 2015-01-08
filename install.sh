#!/bin/bash
FILES=".bashrc .screenrc .vimrc .scripts .i3 .xsession .i3status.conf .gitconfig .tmux.conf"
if [[ ! -d backup-config ]]; then
    mkdir backup-config
fi

for f in $FILES; do
    echo -n "Installing $f... "
    if [[ -h ~/$f ]]; then
        echo "~/$f is already a symbolic link. Please fix it."
        continue
    fi
    if [[ -f ~/$f || -d ~/$f ]]; then
        mv ~/$f backup-config/
    fi
    ln -s $(pwd)/$f ~/$f
    echo "done."
done
