#
# ~/.bashrc
#
export XDG_CURRENT_DESKTOP=Hyprland
set -o vi
export PATH=$PATH:/home/erast/Files/webDonnees/apache-jena-5.3.0/bin

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Created by `pipx` on 2024-12-22 17:29:21
export PATH="$PATH:/home/erast/.local/bin"

#customs

# Automatically do an ls after each cd

alias cdb="builtin cd"

alias cd='cd_func'
cd_func() {
  builtin cd "$@" && ls
}


alias n='nvim'
alias y='yazi'
alias p='sudo pacman -S'
alias ps='sudo pacman -Ss'
alias nvimf='nvim "$(fzf)"'
alias nvimfr='nvim "$(find ~ | fzf)"'
alias cdf='cd "$(dirname "$(fzf)")"'
alias cdfr='cd "$(dirname "$(find ~ | fzf)")"'

alias fcd='source fuzzy-change-directory'
alias clone='alacritty --working-directory "$(pwd)" & disown'


alias night='gammastep -O 3200'
alias bed='shutdown 120 && gammastep -O 2400'
alias shutdownwhen='date --date @$(head -1 /run/systemd/shutdown/scheduled |cut -c6-15)'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# alias gcc='gcc -fdiagnostics-color=always'

PS1='[\[\033[01;32m\]\u\[\033[00m\]][\[\033[01;34m\]\h\[\033[00m\]]\[\033[01;33m\]\w\[\033[00m\]$ '

