# --- Instant Prompt (powerlevel10k) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- Oh My Zsh Setup ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git
  z
  fzf
  zsh-autosuggestions
  zsh-syntax-highlighting
  you-should-use
  zsh-vim-mode
)

source $ZSH/oh-my-zsh.sh

# --- Prompt Configuration ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- Completion ---
autoload -Uz compinit
compinit
COMPLETION_WAITING_DOTS="true"

# --- Vi Mode ---
bindkey -v


# --- Editor ---
export EDITOR='nvim'
export VISUAL="$EDITOR"

# --- History Configuration ---
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt SHARE_HISTORY

# --- Case-insensitive Completion ---
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# --- Performance ---
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 13

# --- Aliases ---
# Automatically do an ls after each cd
alias cd='cd_func'
cd_func() {
  builtin cd "$@" && ls
}
alias n='nvim'
alias y='yazi'
alias p='sudo pacman -S'
alias ps='sudo pacman -Ss'

alias fcd='source fuzzy-change-directory'
alias clone='alacritty --working-directory "$(pwd)" & disown'

alias night='gammastep -O 3200'
alias bed='shutdown 120 && gammastep -O 2400'
alias shutdownwhen='date --date @$(head -1 /run/systemd/shutdown/scheduled |cut -c6-15)'

alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# --- Path Setup (optional, add your paths here) ---
# export PATH="$HOME/bin:/usr/local/bin:$PATH"

