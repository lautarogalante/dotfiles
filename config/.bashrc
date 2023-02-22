#
# ~/.bashrc
export EDITOR='nvim'
export LC_ALL=es_AR.UTF-8

#set -o vi
# If not running interactively, don't do anything

[[ $- != *i* ]] && return

### Alias ###
alias es='setxkbmap es'
alias eu='setxkbmap eu'
alias vi='nvim'
alias v='sudo nvim'
alias s='sudo pacman -S'
alias syu='sudo pacman -Syu'
alias syy='sudo pacman -Syyu'
alias c.='cd ..'
alias c-='cd --'
alias la='ls -la'
alias ld='ls -ashD'
alias x='cd /'
alias D='cd Downloads'
alias q='exit'
alias sm='simple-mtpfs -l'
alias sc='simple-mtpfs --device 1 cell/'

## Alias init and stop Mysql.
alias mysts='sudo systemctl status mysqld'
alias myon='sudo systemctl enable mysqld && systemctl start mysqld'
alias myoff='sudo systemctl stop mysqld && systemctl disable mysqld'

## Apache
alias asts='sudo systemctl status httpd.service'
alias api='sudo systemctl enable httpd.service && systemctl start httpd.service'
alias astp='sudo systemctl stop httpd.service && systemctl disable httpd.service'

## Prompt PS1 
# Original #PS1="[\$(date +%H:%M)] \]\[\e[32;40m\]\u\[\e[m\]\[\e[31m\] : \[\e[m\]\[\e[33m\]\h\[\e[m\]\[\e[36;40m\] \W\[\e[m\] | "
#PS1='\[\e[0m\][\[\e[0m\]\D{}\[\e[0m\]] \[\e[0m\]\u\[\e[0m\]:\[\e[0m\]\H \[\e[0m\]~\[\e[0m\]_\[\e[0m\]|\[\e[0m\]_\[\e[0m\]'
PS1="\[\$(tput setaf 191)\][$(date +%H:%M)] \[$(tput setaf 43)\]\u\[$(tput setaf 136)\]:\[$(tput setaf 251)\]\h \[$(tput setaf 191)\]\w \[$(tput sgr0)\]| "

#source "$HOME/.cargo/env"
#. "$HOME/.cargo/env"

export _JAVA_AWT_WM_NONREPARENTING=1
export PATH=$PATH:/usr/local/mysql/bin
PATH=~/.local/bin:$PATH






























