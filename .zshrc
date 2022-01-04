# Path to your oh-my-zsh installation.
export ZSH="/home/zer0/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git fzf-zsh-plugin)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source $ZSH/oh-my-zsh.sh

# User configuration
export VISUAL=vim
export EDITOR="$VISUAL"v
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH
export PATH=$HOME/langs/go/bin:$PATH
export GOPATH=$HOME/langs/go
export GO111MODULE=on

# export MANPATH="/usr/local/man:$MANPATH"

# aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias vim=nvim
alias v=nvim

### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select
