if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim

export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

export ZSH="$HOME/.oh-my-zsh"

eval "$(/opt/homebrew/bin/brew shellenv)"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias cd="z"
alias ll="ls -la"

# Dotfiles management aliases
alias dotsync='~/dotfiles/scripts/sync.sh'
alias dotupdate='~/dotfiles/scripts/update.sh'
alias dotinstall='~/dotfiles/scripts/install.sh'
alias dotuninstall='~/dotfiles/scripts/uninstall.sh'

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"

source <(fzf --zsh)

FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi
