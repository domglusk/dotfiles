#!/bin/env zsh
export NIXPKGS_ALLOW_UNFREE=1
#noglobalrcs=1
ANON=0
# fzf
export FZF_DEFAULT_COMMAND='rg --files --color=always'
# mdcat
export MDCAT_PAGER='less --pattern=┄+'
# export ZSH_WAKATIME_PROJECT_DETECTION=true
export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"
if [ -e $HOME/ZSH-Sync/.zsh-secrets.zsh ]; then
  source $HOME/ZSH-Sync/.zsh-secrets.zsh
fi
#echo 'sourcing \x1b[36mzshenv'
export PAGER=nvimpager
export MANPAGER=$PAGER
export CLICOLOR=1
export RUST_BACKTRACE=1
#export SOCKS_PROXY=http://192.168.49.1:8448
#export http_proxy=http://192.168.49.1:8228
##export https_proxy=http://192.168.49.1:8080
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZCACHEDIR=$HOME/.cache/zsh
export ZSH_CACHE_DIR=$HOME/.cache/zsh
FZF_HELP_OPTS="--multi --layout=reverse --preview-window=right,75%,wrap --height 80% "
FZF_HELP_OPTS+="--bind ctrl-a:change-preview-window(down,75%,nowrap|right,75%,nowrap)"
CORRECT_IGNORE="*zinit[-]*"
FZF_HELP_SYNTAX='help'
export GREP_OPTIONS='--color=always'
export LS_OPTIONS='--color=always -A -g -h'
export NVIM_TUI_ENABLE_TRUE_COLOR=true
export ZPWR_EXPAND_BLACKLIST=(nvim upall se gpae git-pull-all vim hx sudo grep rg eza ls lsd sudo bat cat)
export ZPWR_EXPAND_SECOND_POSITION=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
export COMMAND_NOT_FOUND_AUTO=1
export LESS='-r -M --mouse -S -I'
# https://github.com/junegunn/fzf/blob/master/ADVANCED.md#ripgrep-integration
# rg foo | fzf
# $word = {2} make a wrong --preview-window
# https://github.com/Aloxaf/fzf-tab/issues/282
# -d$"\0"
export FZF_DEFAULT_OPTS="--preview='bat --color=always --highlight-line={2} {1}
2> ${devnull:-/dev/null} || less {1}'
-m
-d:
--ansi
--reverse
--prompt='❯ '
--pointer=❯
--marker=✓
--scroll-off 3
--bind=tab:down
--bind=btab:up
--bind=ctrl-j:jump
--bind=ctrl-k:kill-line
--bind=ctrl-n:down
--bind=ctrl-p:up
--bind=alt-j:previous-history
--bind=alt-k:next-history
--bind=ctrl-q:clear-query
--bind=alt-a:first
--bind=alt-e:last
--bind=alt-N:toggle-out
--bind=alt-P:toggle-in
--bind=ctrl-space:toggle
--bind=ctrl-o:toggle-all
--bind=ctrl-g:deselect-all
--bind=alt-g:select-all
--bind=ctrl-s:toggle-search
--bind='ctrl-\\:toggle-sort'
--bind=ctrl-^:toggle-preview-wrap
--bind=ctrl-x:toggle-preview
--bind=alt-p:preview-up
--bind=alt-n:preview-down
--bind=ctrl-v:preview-page-down
--bind=alt-v:preview-page-up
--bind=ctrl-r:preview-half-page-down
--bind=alt-r:preview-half-page-up
--bind='alt-<:preview-top'
--bind='alt->:preview-bottom'
--bind='ctrl-]:change-preview-window(bottom|right)'
--bind='alt-space:change-preview-window(+{2}+3/3,~3|+{2}+3/3,~1|)'
--history=$FZF_HISTORY_DIR/fzf.txt
--preview-window=${fzf_opt:-right:50%},border-bottom,+{2}+4/4,~4"
unset devnull fzf_opt
export LMOD_COLORIZE=yes
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit _autin_search_widget fzf-tab-complete)
# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
skip_global_compinit=1

# http://disq.us/p/f55b78

# 10ms for key sequences (Decrease key input delay)
# https://www.johnhawthorn.com/2012/09/vi-escape-delays/
export KEYTIMEOUT=1

## -- Reserved Variables -------------------------------------------------------
## XDG  Base Directory
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
# (( ${+*} )) = if variable is set don't set it anymore. or use [[ -z ${*} ]]
#(( ${+XDG_CONFIG_HOME} )) || export XDG_CONFIG_HOME="$HOME/.config"
#(( ${+XDG_CACHE_HOME}  )) || export XDG_CACHE_HOME="$HOME/.cache"
#(( ${+XDG_DATA_HOME}   )) || export XDG_DATA_HOME="$HOME/.local/share"

## Other System
#(( ${+USER}     )) || export USER="$USERNAME"
#(( ${+HOSTNAME} )) || export HOSTNAME="$HOST"
#(( ${+LANG}     )) || export LANG="en_US.UTF-8"
#(( ${+LANGUAGE} )) || export LANGUAGE="$LANG"
#(( ${+LC_ALL}   )) || export LC_ALL="$LANG"


if ! command -v helix &>/dev/null; then
  export EDITOR=nvim
  export VISUAL=$EDITOR
  export FCEDIT=$EDITOR
  export SYSTEMD_EDITOR=$EDITOR
fi

## -- PATH ---------------------------------------------------------------------
# set PATH so it includes user's private bin if it exists

if [ -d "$HOME/go/bin" ] ; then
  export PATH="$PATH:$HOME/go/bin"
fi


if [ -d "$HOME/.config/emacs/bin" ] ; then
  export PATH="$PATH:$HOME/.config/emacs/bin"
fi

if [ -d "$HOME/Applications" ] ; then
  export PATH="$PATH:$HOME/Applications"
fi

if [ -d "$HOME/bin" ] ; then
  export PATH="$PATH:$HOME/bin"
fi

if [ -d "$HOME/.bin" ] ; then
  export PATH="$PATH:$HOME/.bin"
fi

if [ -d "$HOME/.local/bin" ] ; then
  export PATH="$PATH:$HOME/.local/bin"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
  export PATH="$PATH:$HOME/.cargo/bin"
fi

if [ -d "$HOME/.yarn/bin" ] ; then
  export PATH="$PATH:$HOME/.yarn/bin"
fi

if [ -d "/home/linuxbrew/.linuxbrew/bin" ] ; then
  export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
fi

if [ -d "/snap/bin" ] ; then
  export PATH="$PATH:/snap/bin"
fi

if [ -d "/usr/sbin" ] ; then
  export PATH="$PATH:/usr/sbin"
fi

if [ -d "/usr/local/bin" ] ; then
  export PATH="$PATH:/usr/local/bin"
fi
## -- Cleanup --------------------------------------------------------------------
# remove empty components to avoid '::' ending up + resulting in './' being in $PATH
#path=( "${path[@]:#}" )

## == Zprofile =================================================================
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
export ZDOTDIR=${ZDOTDIR:-$HOME}
 if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
   source "$ZDOTDIR/.zprofile"
 fi

# Conditionally load Pyenv
if command -v pyenv &>/dev/null; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
  export PIP_BREAK_SYSTEM_PACKAGES=1
fi


if [ -e $HOME/.zsh-secrets.zsh ]; then
source $HOME/.zsh-secrets.zsh
fi
# Conditionally load The Fuck
if command -v thefuck &>/dev/null; then
  eval "$(thefuck --alias)"
fi
export ZELLIJ_AUTO_ATTACH=true


export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"


# ZSH configuration options
setopt glob_dots no_auto_menu auto_param_slash complete_in_word interactive_comments path_dirs append_history extended_history hist_ignore_space hist_verify inc_append_history share_history noextendedglob case_glob flow_control menu_complete nocorrect nohistignoredups

# ZSH completion styles and options
zstyle ':completion:*' completer _expand_alias _complete _extensions _match _approximate _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' match-original yes
zstyle ':completion:*' menu select
zstyle ':completion:*:manuals' separate-sections true
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' word true
zstyle ':completion::complete:*' use-cache true
zstyle ':completion:*' option-stacking true
zstyle ':completion::complete:*' call-command true
# Other configurations
export ZSH_COMPDUMP=$ZSH_CACHE_DIR/zcompdump-$HOST
lesspipe.sh | source /dev/stdin   # (zsh)
# ====== SOURCES ======
# https://github.com/alichtman/dotfiles/blob/main/.config/zsh/.zshrc#L66-L67 
# https://github.com/Freed-Wu/Freed-Wu/
# vim: foldmethod=marker foldcolumn=1 et

if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then . ~/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
