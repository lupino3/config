Just another collection of dotfiles
-----------------------------------

This repository contains the configuration files and scripts that I use in
machines that I have access to. Most of them are copied from distro defaults,
examples and so on.

Use and modify them as you wish, I hereby put them in the public domain.

A simple installation script (`install.sh`) is provided. It first backs up any
existing files or directories matching the ones provided by the repo by moving
them to the `backup-config` directory, and then installs the files by creating
symbolic links from the home directory to the git repo directory.
