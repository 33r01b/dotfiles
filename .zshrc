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
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH
export PATH=$HOME/langs/go/bin:$PATH
export GOPATH=$HOME/langs/go

# export MANPATH="/usr/local/man:$MANPATH"

# aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias vim=nvim
alias v=nvim
