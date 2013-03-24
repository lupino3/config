# .bashrc
# Run by bash on interactive shells. Based on debian's bashrc.

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# History handling. Append history, huge size, flush and reload across shells.
shopt -s histappend
export HISTSIZE=100000
export HISTFILESIZE=200000
export HISTCONTROL=ignoredups:ignorespace
export HISTTIMEFORMAT='%F %T '
PROMPT_COMMAND="\history -a; \history -n"

# Editor configuration.
export EDITOR=vim

# Vi mode. Can't live without it.
set -o vi
# .. but let's use emacs mode behaviour of ALT+. (insert last argument)
bind '"\e."':yank-last-arg

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Prompt. Time (hh:mm), current directory and git branch.
create_ps1() {
  local TIME="\A"
  local DIR="\W"
  local GIT_BRANCH="\$(__git_ps1)"  # Will be evaluated every time PS1 is used.

  local fmt_bold=$(tput bold)
  local fmt_green=${fmt_bold}$(tput setaf 2)
  local fmt_blue=${fmt_bold}$(tput setaf 4)
  local fmt_clean=$(tput sgr0)

  echo "${fmt_green}${TIME} ${fmt_blue}${DIR}${fmt_clean}${GIT_BRANCH}\$ "
}
PS1=$(create_ps1)

# Enable color support for ls and grep. Set a few handy aliases.
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Advertise 256 colors support.
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
    export TERM=xterm-256color
fi

# Source local aliases.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# Source other local stuff.
if [ -f ~/.local_bashrc ]; then
    . ~/.local_bashrc
fi
