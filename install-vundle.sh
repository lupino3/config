#!/bin/sh
echo "Downloading Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "Running VundleInstall"
vim +VundleInstall +qall!
