# Set up the prompt

autoload -Uz promptinit
promptinit

setopt appendhistory autocd beep extendedglob nomatch notify
bindkey -v

#ZSH_THEME=refined

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.histfile

VIMINIT=~/.vim/vimrc
VIMRUNTIME=~/.vim

# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

source ~/.zsh/antigen.zsh

# Load the oh-my-zsh's library.
antigen use oh-my-zsh
antigen bundle git
antigen bundle pip
antigen theme denysdovhan/spaceship-prompt
antigen apply

DISABLE_AUTO_TITLE="true"

SPACESHIP_PROMPT_ORDER=(
  time          # Time stamps section
  user          # Username section
  dir           # Current directory section
  host          # Hostname section
  git           # Git section (git_branch + git_status)
  hg            # Mercurial section (hg_branch  + hg_status)
  package       # Package version
  node          # Node.js section
  ruby          # Ruby section
  elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
  php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
  julia         # Julia section
  docker        # Docker section
  aws           # Amazon Web Services section
  #gcloud        # Google Cloud Platform section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
  dotnet        # .NET section
  ember         # Ember.js section
  #kubectl       # Kubectl context section
  terraform     # Terraform workspace section
  exec_time     # Execution time
  line_sep      # Line break
  battery       # Battery level and status
  vi_mode       # Vi-mode indicator
  jobs          # Background jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)
SPACESHIP_EXIT_CODE_SHOW=true

### ALIAS ###

alias pacs='sudo pacman -S'
alias pacr='sudo pacman -R'
alias pacu='sudo pacman -U'
alias pacq='pacman -Q'

alias choco='docker run --rm -v $PWD:$PWD -w $PWD linuturk/mono-choco'

#alias {vim,v}='vim --cmd "set runtimepath^=$HOME/.config/vim" \
#		--cmd "set runtimepath+=$HOME/.config/vim/after" \
#		-u $HOME/.config/vim/vimrc'
alias v=nvim

alias tmux='tmux -2 -f $HOME/.config/tmux/tmux.conf'

alias dr='docker run --rm -it'

# add to path for pip, pipenv and stuff
PATH=$HOME/.local/bin:$PATH

# gitlab cli autocomplete
autoload -U bashcompinit
bashcompinit
#eval "$(register-python-argcomplete gitlab)"
alias gdc='git diff --cached'

# ssh host completion
zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'

TERM=screen-256color

# rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init - zsh)"

# env vars for work
export $(cat ~/.workenv | xargs)
