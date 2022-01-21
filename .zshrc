# Enable colors
autoload -U colors && colors

# Completion
autoload -U compinit
## basic
zstyle ':completion:*' menu select
## case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zmodload zsh/complist
compinit
_comp_options+=(globdots) # include hidden files

# History
export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=$HOME/.cache/.zsh_history

# Load zsh-syntax-highlighting (pacman -S zsh-syntax-highlighting)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh 2>/dev/null
# Search repos for programs that can't be found
source /usr/share/doc/pkgfile/command-not-found.zsh 2>/dev/null

# Load plugins
[ -f ~/.config/zsh/fzf.plugin.zsh ] && source ~/.config/zsh/fzf.plugin.zsh

# User configuration
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH
export PATH=$HOME/langs/go/bin:$PATH
export GOPATH=$HOME/langs/go
export GO111MODULE=on

# Aliases
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias vim=nvim
alias v=nvim
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto' 
alias fgrep='fgrep --colour=auto'

# Keybindings
## ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
## ctrl + space to accept the current zsh-autosuggestions
bindkey '^ ' autosuggest-accept
## urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word
# history
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

#autoload -U promptinit && promptinit

# Find and set branch name var if in git repository.
function git_branch_name()
{
    branch=$(git symbolic-ref HEAD 2> /dev/null | awk 'BEGIN{FS="/"} {print $NF}')
    if [[ $branch == "" ]];
    then
        :
    else
        if [ -n "$(git status --porcelain)" ]; then
            local gitstatuscolor="%F{red}${branch}%f"
        else
            local gitstatuscolor="%F{green}${branch}%f"
        fi
        echo " %F{white}%f %F{white}[%f${gitstatuscolor}%F{white}]%f"
    fi
}

# Enable substitution in the prompt.
setopt prompt_subst
# Config for prompt. PS1 synonym.
PROMPT='%F{green}%f  %F{cyan}%B%1/%b%f$(git_branch_name) '

# Colorized man pages
man() {
    LESS_TERMCAP_md=$'\e[01;31m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;44;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[01;32m' \
    command man "$@"
}
