# auto complete for ddev
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

if [ -f "$HOME/.docker/completions/_docker" ] ; then
  FPATH="$HOME/.docker/completions:$FPATH"
fi

export XDG_DOWNLOAD_DIR="$HOME/Downloads"

export HOMEBREW_NO_AUTO_UPDATE="1"

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
  PATH="$HOME/.carbo/bin:$PATH"
fi

if [ -f "$HOME/.cargo/env" ] ; then
  source "$HOME/.cargo/env"
fi

if [ -d "$HOME/.local/scripts" ] ; then
  PATH="$HOME/.local/scripts:$PATH"
fi

if [ -d "$(composer -n config --global home)/vendor/bin" ]; then
  PATH="$(composer -n config --global home)/vendor/bin:$PATH"
fi

if [ -f "$(mkcert -CAROOT)/rootCA.pem" ] ; then
  export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
fi

if [ -L "/opt/homebrew/opt/php@8.2" ] && [ -d "/opt/homebrew/opt/php@8.2" ] ; then
  alias php82="/opt/homebrew/opt/php@8.2/bin/php"
fi

if [ -L "/opt/homebrew/opt/php@8.1" ] && [ -d "/opt/homebrew/opt/php@8.1" ] ; then
  alias php81="/opt/homebrew/opt/php@8.1/bin/php"
fi

if [ -L "/opt/homebrew/opt/php@8.0" ] && [ -d "/opt/homebrew/opt/php@8.0" ] ; then
  alias php80="/opt/homebrew/opt/php@8.0/bin/php"
fi
  
###
# Env variables
###
export EDITOR='nvim'
export TERM='xterm-256color'

###
# 1Password specific
###
if [ -e "$HOME/.1password/agent.sock" ] ; then
  export SSH_AUTH_SOCK=~/.1password/agent.sock
fi


if [ -f "$(mkcert -CAROOT)/rootCA.pem" ] ; then
  export NODE_EXTRA_CA_CERTS="$(mkcert -CAROOT)/rootCA.pem"
fi


###
# History settings
###
export HISTFILE=$HOME/.zsh_history
export HISTSIZE=100000
export SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY

###
# Plugin settings
###
WORDCHARS=${WORDCHARS//[\/]}
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
function zvm_config() {
   ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
   ZVM_VI_INSERT_ESCAPE_BINDKEY=jk
}

###
# Zim plugin manager setup
###
zstyle ':zim:zmodule' use 'degit'
ZIM_HOME=$HOME/.cache/zim

# Download zimfw plugin manager if missing.
if [[ ! -e ${ZIM_HOME}/zimfw.zsh ]]; then
  curl -fsSL --create-dirs -o ${ZIM_HOME}/zimfw.zsh \
      https://github.com/zimfw/zimfw/releases/latest/download/zimfw.zsh
fi

# Install missing modules, and update ${ZIM_HOME}/init.zsh if missing or outdated.
if [[ ! ${ZIM_HOME}/init.zsh -nt ${ZDOTDIR:-${HOME}}/.zimrc ]]; then
  source ${ZIM_HOME}/zimfw.zsh init -q
fi

# Initialize modules.
source ${ZIM_HOME}/init.zsh

###
# Keybindings
###
# Bind ^[[A/^[[B manually so up/down works both before and after zle-line-init
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Bind up and down keys
zmodload -F zsh/terminfo +p:terminfo
if [[ -n ${terminfo[kcuu1]} && -n ${terminfo[kcud1]} ]]; then
  bindkey ${terminfo[kcuu1]} history-substring-search-up
  bindkey ${terminfo[kcud1]} history-substring-search-down
fi

bindkey '^P' history-substring-search-up
bindkey '^N' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

bindkey -s '^f' 'tmux-sessionizer\n'
bindkey -s '^a' 'tmux attach\n'

alias ls="ls --color=auto"
alias l="ls --color=auto -lah"
alias v="nvim"
alias gst="git status"
alias gaa="git add --all"
alias gcmsg="git commit -m"
alias gp="git push"
# alias glog="git log --oneline --decorate --graph"
alias glog="git log --pretty=format:%Cgreen%h\ %Cred%d\ %Creset%s\ %Cblue\[%an\ -\ %aD\] --graph --abbrev-commit"
alias tma="tmux attach"
alias tms="tmux-sessionizer"
alias dcraft="ddev craft"
alias da="ddev artisan"
alias dnpm="ddev npm"
alias dcomp="ddev composer"
alias nvimdiff="nvim -d"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/samer/.lmstudio/bin"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/samer/.lmstudio/bin"
# End of LM Studio CLI section

