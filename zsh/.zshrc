if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR=nvim
export JAVA_HOME="/opt/homebrew/opt/openjdk@21/libexec/openjdk.jdk/Contents/Home"
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$JAVA_HOME/bin:$PATH

[[ -f "$HOME/dotfiles/.env" ]] && source "$HOME/dotfiles/.env"

export ZSH="$HOME/.oh-my-zsh"

eval "$(/opt/homebrew/bin/brew shellenv)"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

alias cd="z"
alias ll="ls -la"
alias dotsync='~/dotfiles/scripts/sync.sh'
alias dotupdate='~/dotfiles/scripts/update.sh'
alias dotinstall='~/dotfiles/scripts/install.sh'
alias dotuninstall='~/dotfiles/scripts/uninstall.sh'
alias dotcheck='~/dotfiles/scripts/check_packages.sh'
alias docker="podman"
alias docker-compose="podman-compose"
alias aws-login="aws sso login --profile $POWER_USER_ACCESS"

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(zoxide init zsh)"

source <(fzf --zsh)

FNM_PATH="/opt/homebrew/opt/fnm/bin"
if [ -d "$FNM_PATH" ]; then
  eval "`fnm env`"
fi

export PNPM_HOME="/Users/tanmay/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)
