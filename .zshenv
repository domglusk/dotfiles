#! /usr/bin/env zsh
autoload -Uz url-quote-magic compinit
zle -N self-insert url-quote-magic
lessc () { /usr/share/nvim/runtime/macros/less.sh "$@"}
noglobalrcs=1
ANON=0

#==# Testing out Base16, attempting to convert the kitty colorscheme I use to it
# Base16 Shell
# BASE16_SHELL_PATH="$HOME/.config/base16-shell"
# [ -n "$PS1" ] && \
#   [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
#     source "$BASE16_SHELL_PATH/profile_helper.sh"
# export BASE16_SHELL=$BASE16_SHELL_PATH
# export BASE16_THEME_DEFAULT=ayu-mirage
export BASE16_THEME_DEFAULT=horizon-terminal-dark
export BASE16_THEME=horizon-terminal-dark
export BASE16_COLOR_00_HEX="#232627"
export BASE16_COLOR_01_HEX="#ED1515"
export BASE16_COLOR_02_HEX="#11d116"
export BASE16_COLOR_03_HEX="#fe6740"
export BASE16_COLOR_04_HEX="#1d99f3"
export BASE16_COLOR_05_HEX="#9b59b6"
export BASE16_COLOR_06_HEX="#1abc9c"
export BASE16_COLOR_07_HEX="#fcfcfc"
export BASE16_COLOR_08_HEX="#626880"
export BASE16_COLOR_09_HEX="#c0392b"
export BASE16_COLOR_0A_HEX="#17a262"
export BASE16_COLOR_0B_HEX="#fdbc4b"
export BASE16_COLOR_0C_HEX="#3daee9"
export BASE16_COLOR_0D_HEX="#8e44ad"
export BASE16_COLOR_0E_HEX="#16a085"
export BASE16_COLOR_0F_HEX="#ffffff"

export BASE16_SHELL_ENABLE_VARS=1

export BAT_THEME='Monokai Extended Bright'
export HAS_ALLOW_UNSAFE=y
export FZF_DEFAULT_COMMAND='rg --files --color=always'
export MDCAT_PAGER='less --pattern=┄+'
export LOCALE_ARCHIVE="$HOME/.nix-profile/lib/locale/locale-archive"
if [ -e $HOME/ZSH-Sync/.zsh-secrets.zsh ]; then
    source $HOME/ZSH-Sync/.zsh-secrets.zsh
fi
export PAGER=less
export CLICOLOR=1
export RUST_BACKTRACE=1
export ZCACHEDIR=$HOME/.cache/zsh
export ZSH_CACHE_DIR=$HOME/.cache/zsh
FZF_HELP_OPTS="--multi --layout=reverse --preview-window=right,75%,wrap --height 80% "
FZF_HELP_OPTS+="--bind ctrl-a:change-preview-window(down,75%,nowrap|right,75%,nowrap)"
CORRECT_IGNORE="*zinit[-]*"
FZF_HELP_SYNTAX='help'
export GREP_OPTIONS='--color=always'
export NVIM_TUI_ENABLE_TRUE_COLOR=true
export ZPWR_EXPAND_BLACKLIST=(nvim upall se gpae git-pull-all vim hx sudo grep rg eza ls lsd sudo bat cat)
export ZPWR_EXPAND_SECOND_POSITION=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
export COMMAND_NOT_FOUND_AUTO=1
# https://github.com/junegunn/fzf/blob/master/ADVANCED.md#ripgrep-integration
# rg foo | fzf
# $word = {2} make a wrong --preview-window
# https://github.com/Aloxaf/fzf-tab/issues/282
# -d$"\0"
export FZF_DEFAULT_OPTS="
-m
-d:
--cycle
--scroll-off=3
--height=40
--min-height=5
--reverse
--prompt='❯ '
--pointer=❯
--marker=✓
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
--preview-window=wrap,${fzf_opt:-right:50%},border-bottom,+{2}+4/4,~4"
unset devnull fzf_opt
# export FZF_DEFAULT_OPTS="--cycle --layout=reverse --height=90% --preview-window=wrap --scroll-off=3 --bind tab:down,shift-tab:up --marker="*""

export LMOD_COLORIZE=yes

ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit _autin_search_widget fzf-tab-complete)
if [ -x manpager ]; then
MANPAGER=manpager
else
MANPAGER=$PAGER
fi
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
export EDITOR=helix
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


if [ -e $HOME/.zsh-secrets.zsh ]; then
    source $HOME/.zsh-secrets.zsh
fi
eval $(thefuck --alias)
export ZELLIJ_AUTO_ATTACH=true

lsd_params+="-A"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

# ZSH configuration options
setopt glob_dots no_auto_menu auto_param_slash complete_in_word interactive_comments path_dirs append_history extended_history hist_ignore_space hist_verify inc_append_history share_history noextendedglob case_glob flow_control menu_complete nocorrect nohistignoredups
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
zstyle '*' single-ignored show
zstyle ':completion:*' group-name ''
zstyle ':completion:*' verbose yes
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:*:*:*:*' ignore-line 'yes'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:*:*:processes' command 'ps -u $LOGNAME -o pid,user,command -w'
zstyle ':completion:*:*:-command-:*:*' group-order functions builtins commands
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*:*:cd:*:directory-stack' menu yes select
zstyle ':completion:*:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' insert-ids single
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;36=0=01'
zstyle ':completion:*:-tilde-:*' group-order 'named-directories' 'path-directories' 'users' 'expand'
zstyle ':completion:*:approximate:*' max-errors 1 numeric
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:history-words' remove-all-dups yes
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'full'
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
zstyle ':completion:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion::*:(-command-|export):*' fake-parameters ${${${_comps[(I)-value-*]#*,}%%,*}:#-*-}
zstyle -e ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*:ssh:*' group-order users hosts-domain hosts-host users hosts-ipaddr
zstyle ':completion:*:ssh:*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle -e ':completion:*:hosts' hosts 'reply=(
${=${=${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) 2>/dev/null)"}%%[#| ]*}//\]:[0-9]*/ }//,/ }//\[/ }
${=${(f)"$(cat /etc/hosts(|)(N) <<(ypcat hosts 2>/dev/null))"}%%\#*}
${=${${${${(@M)${(f)"$(cat ~/.ssh/config 2>/dev/null)"}:#Host *}#Host }:#*\**}:#*\?*}}
)'
zstyle ':completion:*:*:*:users' ignored-patterns adm amanda apache avahi beaglidx bin cacti canna clamav daemon dbus distcache dovecot fax ftp games gdm gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust ldap lp mail mailman mailnull mldonkey mysql nagios named netdump news nfsnobody nobody nscd ntp nut nx openvpn operator pcap postfix postgres privoxy pulse pvm quagga radvd rpc rpcuser rpm shutdown squid sshd sync uucp vcsa xfs '_*'
zstyle ':completion:*:(scp|rsync):*' group-order users files all-files hosts-domain hosts-host hosts-ipaddr
zstyle ':completion:*:(scp|rsync):*' tag-order 'hosts:-host:host hosts:-domain:domain hosts:-ipaddr:ip\ address *'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-domain' ignored-patterns '<->.<->.<->.<->' '^[-[:alnum:]]##(.[-[:alnum:]]##)##' '*@*'
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-host' ignored-patterns '*(.|:)*' loopback ip6-loopback localhost ip6-localhost broadcasthost
zstyle ':completion:*:(ssh|scp|rsync):*:hosts-ipaddr' ignored-patterns '^(<->.<->.<->.<->|(|::)([[:xdigit:].]##:(#c,2))##(|%*))' '127.0.0.<->' '255.255.255.255' '::1' 'fe80::*'
zstyle ':completion:*' range 1000:100 # Try 100 history words at a time; max 1000 words.
zstyle ':completion:*' completer _complete _extensions _match _approximate _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*' menu select
zstyle ':completion:*' word true
zstyle ':completion::*:complete:*' use-cache true
zstyle ':completion:*' option-stacking true
zstyle ':completion:*' group-name ''
zstyle ':completion:*:verbose' yes
zstyle ':completion:*:(rm|kill|diff):*' ignore-line other
zstyle ':completion:*:*:*:*:*' ignore-line 'yes'
zstyle ':completion::*:-command-:*:*' group-order functions builtins commands
zstyle ':completion::*:-subscript-:*' tag-order indexes parameters
zstyle ':completion::*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' list-separator ''
zstyle ':completion::*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:processes' command "ps -wu$USER -opid,user,comm"
zstyle ':completion:*:descriptions' format %d
zstyle ':completion::*:fzf-tab:*' prefix '' single-group prefix color header continuous-trigger 'ctrl-_' switch-group 'alt-,' 'alt-.'

export ZSH_COMPDUMP=$ZSH_CACHE_DIR/zcompdump-$HOST
export ZSHENV_SOURCED=1
# ====== SOURCES ======
# https://github.com/alichtman/dotfiles/blob/main/.config/zsh/.zshrc#L66-L67
# https://github.com/Freed-Wu/Freed-Wu/
# https://github.com/vladdoster/dotfiles/tree/master/zsh
