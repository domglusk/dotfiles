
export ZSH_WAKATIME_PROJECT_DETECTION=true
if [ -e /home/domglusk/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/domglusk/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer
export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"
if [ -e $HOME/ZSH-Sync/.zsh-secrets.zsh ]; then
  source $HOME/ZSH-Sync/.zsh-secrets.zsh
fi
#echo 'sourcing \x1b[36mzshenv'
export CLICOLOR=1
export RUST_BACKTRACE=1
#export SOCKS_PROXY=http://192.168.49.1:8448
#export http_proxy=http://192.168.49.1:8228
##export https_proxy=http://192.168.49.1:8080
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZCACHEDIR=$HOME/.cache/zsh
export ZSH_CACHE_DIR=$HOME/.cache/zsh
export FZF_HELP_OPTS="--multi --layout=reverse --preview-window=right,75%,wrap --height 80% "
FZF_HELP_OPTS+="--bind ctrl-a:change-preview-window(down,75%,nowrap|right,75%,nowrap)"
export vivid_theme="catppuccin-mocha"
export LS_COLORS="$(vivid generate molokai)"
export FZF_DEFAULT_COMMAND='rg --files --color=always'
CORRECT_IGNORE="*zinit[-]*"
ZSH_THEME="pygmalion-virtualenv"
export FZF_HELP_SYNTAX='help'
export HELIX_RUNTIME=$HOME/.config/helix/runtime
export FZF_DEFAULT_OPTS='--cycle --layout=reverse --border --height=90% --preview-window=wrap --scroll-off=3 --bind 'tab:down,shift-tab:up''
 export FZF_DEFAULT_OPTS="--preview='bat --color=always --highlight-line={2} {1}
 2> ${devnull:-/dev/null} || bat {1}'
 -m
 -d:
 --ansi
 --reverse
 --prompt='❯ '
 --pointer=❯
 --marker=✓
 --scroll-off=3
 --bind=tab:down
 --bind=btab:up
 --bind=ctrl-q:clear-query
 --bind=alt-a:first
 --preview-window=${fzf_opt:-right:50%},border-bottom,+{2}+4/4,~4"
 unset devnull fzf_opt
export NVIM_TUI_ENABLE_TRUE_COLOR=true
export ZPWR_EXPAND_BLACKLIST=(nvim upall se gpae git-pull-all vim hx sudo grep rg eza ls lsd sudo bat cat)
export ZPWR_EXPAND_SECOND_POSITION=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export COMMAND_NOT_FOUND_AUTO=1
alias lsd="lsd --sort extension --group-directories-first -h -A"
#alias ls="lsd"

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
(( ${+XDG_CONFIG_HOME} )) || export XDG_CONFIG_HOME="$HOME/.config"
(( ${+XDG_CACHE_HOME}  )) || export XDG_CACHE_HOME="$HOME/.cache"
(( ${+XDG_DATA_HOME}   )) || export XDG_DATA_HOME="$HOME/.local/share"

## Other System
(( ${+USER}     )) || export USER="$USERNAME"
(( ${+HOSTNAME} )) || export HOSTNAME="$HOST"
(( ${+LANG}     )) || export LANG="en_US.UTF-8"
(( ${+LANGUAGE} )) || export LANGUAGE="$LANG"
(( ${+LC_ALL}   )) || export LC_ALL="$LANG"

# Common Apps
# https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap08.html#tag_08_01
export EDITOR=nvim
export VISUAL=$EDITOR
export FCEDIT=$EDITOR
export SYSTEMD_EDITOR=$EDITOR # for systemctl
## -- PATH ---------------------------------------------------------------------
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/Application" ] ; then
  export PATH="$PATH:$HOME/Application"
fi

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
path=( "${path[@]:#}" )

## eliminates duplicates in *paths

## == Zprofile =================================================================
# https://github.com/sorin-ionescu/prezto/blob/master/runcoms/zshenv
# Ensure that a non-login, non-interactive shell has a defined environment.
export ZDOTDIR=${ZDOTDIR:-$HOME}
 if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "$ZDOTDIR/.zprofile" ]]; then
   source "$ZDOTDIR/.zprofile"
 fi


export NIXPKGS_ALLOW_UNFREE=1

# Pyenv Configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PIP_BREAK_SYSTEM_PACKAGES=1

# Alias
alias -g vim="nvim"
alias -g hx="helix"

if [ -e $HOME/.zsh-secrets.zsh ]; then
source $HOME/.zsh-secrets.zsh
fi
eval $(thefuck --alias)
export ZELLIJ_AUTO_ATTACH=true




fpath=(
   $fpath
   $HOME/.local/share/zsh/generated_man_completions
)
alias sudo="sudo "

# ZSH configuration options
setopt auto_cd auto_list glob_dots no_auto_menu auto_param_slash complete_in_word interactive_comments path_dirs append_history extended_history hist_ignore_space hist_verify inc_append_history share_history noextendedglob case_glob flow_control menu_complete

# ZSH completion styles and options
zstyle ':completion:*' completer _expand_alias _complete _extensions _match _approximate _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'

# FZF configuration
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' single-group prefix color header
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-_'
zstyle ':fzf-tab:*' switch-group 'alt-,' 'alt-.'

# Other configurations
export ZSH_COMPDUMP=#ZSH_CACHE_DIR/zcompdump-$HOST

# FZF preview configurations
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'



# ====== SOURCES ======
# https://github.com/alichtman/dotfiles/blob/main/.config/zsh/.zshrc#L66-L67 
# vim: foldmethod=marker foldcolumn=1 et
