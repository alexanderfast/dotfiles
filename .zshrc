# ~/.zshrc — interactive zsh configuration
# Layout: options -> PATH/env -> compinit -> plugins -> completions -> tools -> keybindings -> aliases
# (to profile: uncomment `zmodload zsh/zprof` here and `zprof` at the very end)
# zmodload zsh/zprof

#
# Shell options & history
#
bindkey -v                          # vi keybindings

setopt AUTO_PARAM_SLASH             # trailing slash on completed dirs
setopt CHECK_JOBS                   # warn about bg jobs on exit
setopt EXTENDED_GLOB                # #, ~ and ^ globbing
setopt EXTENDED_HISTORY             # timestamps in history
setopt GLOB_DOTS                    # match dotfiles without leading dot
setopt HASH_CMDS                    # cache command locations
setopt HIST_EXPIRE_DUPS_FIRST       # drop dupes first when trimming history
setopt HIST_NO_STORE                # don't store the history command itself
setopt INC_APPEND_HISTORY           # append as commands run
setopt LIST_ROWS_FIRST              # completion grid left-to-right
setopt LIST_TYPES                   # show file types in completion list
setopt MARK_DIRS                    # trailing slash on globbed dirs
setopt MAGIC_EQUAL_SUBST            # complete after `foo=`
setopt SHARE_HISTORY                # share history across sessions
unsetopt AUTOCD                     # don't cd just by typing a dir name
unsetopt BEEP                       # no bell

HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.histfile
HIST_STAMPS="yyyy-mm-dd"

DOTFILES="$HOME/.config"
DISABLE_AUTO_TITLE="true"
HYPHEN_INSENSITIVE="true"
export ZSH_COLORIZE_TOOL=chroma

#
# PATH & environment — set BEFORE command lookups, compinit and plugins
# so `(( $+commands[...] ))` checks and completions see the right tools.
#
path=(
  $HOME/.local/bin
  $HOME/.npm-global/bin
  $HOME/go/bin
  $path
  /opt/nvim-linux-x86_64/bin
  /usr/local/go/bin
)
export GOPATH=$HOME/go
path+=$GOPATH/bin
typeset -U path                     # keep PATH deduplicated

export ANSIBLE_NOCOWS=1
export PIPENV_VENV_IN_PROJECT=1
export CLAUDE_CODE_DISABLE_TERMINAL_TITLE=1
# Claude Code captures the mouse and copies text on select; disabling its mouse
# clicks stops that extra copy, so selecting text gives a single clipboard
# toast (tmux's) instead of two. Wheel scroll still works.
export CLAUDE_CODE_DISABLE_MOUSE_CLICKS=1
export BATMCP_SECRETS_FILE="$HOME/.secrets"

# nvm
export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# rvm
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

#
# Plugin configuration — must be set before the plugins load
#
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_UNICODE=true
ZSH_TMUX_AUTOCONNECT=true

#
# Completion init — rebuild + security-audit the dump at most once a day,
# otherwise trust the cache (compinit -C) so startup stays fast.
#
autoload -Uz compinit
if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qNmh-24) ]]; then
  compinit -C
else
  compinit
fi

#
# Plugins via antidote — statically compiled to a single flat file for speed,
# regenerated only when the manifest (zsh_plugins.txt) changes. Pinned: plugins
# stay at their cloned commit until an explicit `antidote update`.
#
source ~/.antidote/antidote.zsh
_zsh_plugins_txt=~/.config/zsh/zsh_plugins.txt
_zsh_plugins_zsh=~/.config/zsh/zsh_plugins.zsh
if [[ ! ${_zsh_plugins_zsh} -nt ${_zsh_plugins_txt} ]]; then
  antidote bundle <${_zsh_plugins_txt} >| ${_zsh_plugins_zsh}
fi
source ${_zsh_plugins_zsh}
unset _zsh_plugins_txt _zsh_plugins_zsh

# common-aliases sets `cp -i`/`mv -i`/`rm -i`, whose overwrite prompts hang
# non-interactive agents (Claude Code) that can't answer them. Keep the safety
# net for real interactive use; drop it inside Claude Code sessions.
if [[ -n ${CLAUDECODE} ]]; then
  unalias cp mv rm 2>/dev/null
fi

#
# Completion styling
#
zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}"
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
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

# Tool-provided completions (after PATH is set so the tools resolve)
if (( $+commands[glab] )); then
  source <(glab completion -s zsh); compdef _glab glab
fi
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi

#
# Prompt
#
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

#
# fzf — keybindings + catppuccin theme, kept in sync with whichever fzf is on
# PATH. Nix devshells can shadow the system fzf with an older build; the widgets
# are baked once at startup, so a widget built by fzf 0.67 (binds
# alt-r:toggle-raw) fails against a devshell's 0.62 ("unknown action:
# toggle-raw") and Ctrl-R silently dies. Regenerate only when the resolved fzf
# binary changes (no per-prompt fork; ${commands[fzf]} is a hash lookup) so the
# baked options — and the version-gated colors — always match the running fzf.
#
typeset -g FZF_DEFAULT_OPTS_BASE="
--color=bg:#1E1E2E,bg+:#45475A
--color=fg:#CDD6F4,fg+:#CDD6F4
--color=hl:#F38BA8,hl+:#F38BA8
--color=spinner:#F5E0DC
--color=header:#F38BA8
--color=info:#CBA6F7
--color=pointer:#F5E0DC
--color=marker:#B4BEFE
--color=prompt:#CBA6F7
"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

typeset -g _FZF_SYNCED_PATH
_fzf_sync_bindings() {
  local p=${commands[fzf]}
  [[ $p == $_FZF_SYNCED_PATH ]] && return
  _FZF_SYNCED_PATH=$p
  [[ -z $p ]] && return
  FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS_BASE
  autoload -Uz is-at-least
  if is-at-least 0.67 "${${(z)$(fzf --version)}[1]}"; then
    FZF_DEFAULT_OPTS+=$'\n--color=border:#6C7086\n--color=label:#CDD6F4'
  fi
  export FZF_DEFAULT_OPTS
  source <(fzf --zsh)
}
autoload -Uz add-zsh-hook
add-zsh-hook precmd _fzf_sync_bindings

#
# Keybindings
#
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

#
# Aliases & functions
#
source $DOTFILES/zsh/zsh_aliases
source $DOTFILES/zsh/zsh_functions

# zprof

# Resume Claude Code sessions without copying the session ID
alias clc='claude --continue'  # resume most recent session in current dir (cc = C compiler)
alias ccr='claude --resume'    # global picker across all sessions
