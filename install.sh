#!/bin/bash
FILES=".screenrc .vimrc .scripts .vim"
if [[ ! -d backup-config ]]; then
    mkdir backup-config
fi

for f in $FILES; do
    if [[ -h ~/$f ]]; then
        echo "~/$f is already a symbolic link. Please fix it."
        continue
    fi
    if [[ -f ~/$f || -d ~/$f ]]; then
        mv ~/$f backup/
    fi
    ln -s $f ~/$f
done