autoload -Uz promptinit colors
promptinit
colors

[ -f ~/.config/zsh/fzf.plugin.zsh ] && source ~/.config/zsh/fzf.plugin.zsh

# User configuration
export HISTFILE=$HOME/.cache/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
export VISUAL=nvim
export EDITOR="$VISUAL"
export PATH=$HOME/.local/bin:/usr/local/bin:$HOME/.npm-global/bin:$PATH
export PATH=$HOME/langs/go/bin:$PATH
export GOPATH=$HOME/langs/go
export GO111MODULE=on

# export MANPATH="/usr/local/man:$MANPATH"

# aliases
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles --work-tree=$HOME'
alias vim=nvim
alias v=nvim
alias ls='ls --color=auto'
alias grep='grep --colour=auto'
alias egrep='egrep --colour=auto' 
alias fgrep='fgrep --colour=auto'

### ctrl+arrows
bindkey "\e[1;5C" forward-word
bindkey "\e[1;5D" backward-word
# urxvt
bindkey "\eOc" forward-word
bindkey "\eOd" backward-word
# ctrl + space to accept the current zsh-autosuggestions
bindkey '^ ' autosuggest-accept

# history
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

autoload -Uz compinit
compinit

zstyle ':completion:*' menu select

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
