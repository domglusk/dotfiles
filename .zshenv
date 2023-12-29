export ZSH_WAKATIME_PROJECT_DETECTION=true
if [ -e /home/domglusk/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/domglusk/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer
#export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"
ZCOMPDUMP=$XDG_CACHE_DIR/.cache/zsh/zcompdump
export COMPLETION_WAITING_DOTS="true"
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
FZF_HELP_OPTS="--multi --layout=reverse --preview-window=right,75%,wrap --height 80% "
FZF_HELP_OPTS+="--bind ctrl-a:change-preview-window(down,75%,nowrap|right,75%,nowrap)"
export vivid_theme="catppuccin-mocha"
# export FZF_DEFAULT_COMMAND='rg --files --color=always'
export FZF_HELP_SYNTAX='help'
export FZF_DEFAULT_OPTS="--scroll-off=3"
# export FZF_DEFAULT_OPTS="--preview='bat --color=always --highlight-line={2} {1}
# 2> ${devnull:-/dev/null} || bat {1}'
# -m
# -d:
# --ansi
# --reverse
# --prompt='❯ '
# --pointer=❯
# --marker=✓
# --scroll-off=3
# --bind=tab:down
# --bind=btab:up
# --bind=ctrl-j:jump
# --bind=ctrl-k:kill-line
# --bind=ctrl-n:down
# --bind=ctrl-p:up
# --bind=alt-j:previous-history
# --bind=alt-k:next-history
# --bind=ctrl-q:clear-query
# --bind=alt-a:first
# --bind=alt-e:last
# --bind=alt-N:toggle-out
# --bind=alt-P:toggle-in
# --bind=ctrl-space:toggle
# --bind=ctrl-o:toggle-all
# --bind=ctrl-g:deselect-all
# --bind=alt-g:select-all
# --bind=ctrl-s:toggle-search
# --bind='ctrl-\\:toggle-sort'
# --bind=ctrl-^:toggle-preview-wrap
# --bind=ctrl-x:toggle-preview
# --bind=alt-p:preview-up
# --bind=alt-n:preview-down
# --bind=ctrl-v:preview-page-down
# --bind=alt-v:preview-page-up
# --bind=ctrl-r:preview-half-page-down
# --bind=alt-r:preview-half-page-up
# --bind='alt-<:preview-top'
# --bind='alt->:preview-bottom'
# --bind='ctrl-]:change-preview-window(bottom|right)'
# --bind='alt-space:change-preview-window(+{2}+3/3,~3|+{2}+3/3,~1|)'
# --preview-window=${fzf_opt:-right:50%},border-bottom,+{2}+4/4,~4"
# unset devnull fzf_opt
export NVIM_TUI_ENABLE_TRUE_COLOR=true
export ZPWR_EXPAND_BLACKLIST=(nvim upall se gpae git-pull-all vim hx sudo grep rg eza ls lsd sudo bat cat)
export ZPWR_EXPAND_SECOND_POSITION=true
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=50
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export COMMAND_NOT_FOUND_AUTO=1
export lsd_params="--sort extension --group-directories-first -h -A"
alias lsd="lsd $lsd_params"

export ZSH_AUTOSUGGEST_STRATEGY=(match_prev_cmd completion history)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste up-line-or-search down-line-or-search expand-or-complete accept-line push-line-or-edit _autin_search_widget fzf-tab-complete)


# https://blog.patshead.com/2011/04/improve-your-oh-my-zsh-startup-time-maybe.html
# skip_global_compinit=1

# http://disq.us/p/f55b78

# 10ms for key sequences (Decrease key input delay)
# https://www.johnhawthorn.com/2012/09/vi-escape-delays/
export KEYTIMEOUT=1

## -- Reserved Variables -------------------------------------------------------
## XDG  Base Directory
# https://specifications.freedesktop.org/basedir-spec/latest/
# https://wiki.archlinux.org/index.php/XDG_Base_Directory
## (( ${+*} )) = if variable is set don't set it anymore. or use [[ -z ${*} ]]
# (( ${+XDG_CONFIG_HOME} )) || export XDG_CONFIG_HOME="$HOME/.config"
# (( ${+XDG_CACHE_HOME}  )) || export XDG_CACHE_HOME="$HOME/.cache"
# (( ${+XDG_DATA_HOME}   )) || export XDG_DATA_HOME="$HOME/.local/share"
#
# ## Other System
# (( ${+USER}     )) || export USER="$USERNAME"
# (( ${+HOSTNAME} )) || export HOSTNAME="$HOST"
# (( ${+LANG}     )) || export LANG="en_US.UTF-8"
# (( ${+LANGUAGE} )) || export LANGUAGE="$LANG"
# (( ${+LC_ALL}   )) || export LC_ALL="$LANG"

## Common Apps
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

# Additional customization can be done as per your preference

# Base16 Shell
BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
 [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
   source "$BASE16_SHELL_PATH/profile_helper.sh"




if [ -f /etc/zsh_command_not_found ]; then
   . /etc/zsh_command_not_found
fi

# Pyenv Configuration
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PIP_BREAK_SYSTEM_PACKAGES=1

# Alias
alias -g vim="lvim"
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
# ZDOTDIR=/home/domglusk/.cache/zsh/
# fpath+=($ZDOTDIR $fpath)
# autoload -Uz compinit
# compinit -d $ZDOTDIR/.zcompdump-$ZSH_VERSION
#revolver stop
export MANPAGER=/usr/bin/manpager

# Setopt
setopt auto_cd
setopt auto_list
setopt auto_menu
setopt auto_param_slash
setopt complete_in_word
setopt glob_dots
setopt interactive_comments
setopt path_dirs
setopt append_history         # Allow multiple sessions to append to one Zsh command history.
setopt extended_history       # Show timestamp in history.
setopt hist_ignore_space      # Do not record an Event Starting With A Space.
setopt hist_verify            # Do not execute immediately upon history expansion.
setopt inc_append_history     # Write to the history file immediately, not when the shell exits.
setopt share_history          # Share history between different instances of the shell.

unsetopt case_glob
unsetopt flow_control
unsetopt menu_complete

zstyle '*' single-ignored show
zstyle ':completion:*' completer _expand_alias _complete _match _approximate _ignored
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' rehash true
zstyle ':completion:*' squeeze-slashes true
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
zstyle ':completion:*:corrections' format ' %F{green}-- %d (errors: %e) --%f'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:default' list-prompt '%S%M matches%s'
zstyle ':completion:*:descriptions' format ' %F{yellow}-- %d --%f'
zstyle ':completion:*:functions' ignored-patterns '(_*|pre(cmd|exec))'
zstyle ':completion:*:history-words' list false
zstyle ':completion:*:history-words' menu yes
zstyle ':completion:*:history-words' stop yes
zstyle ':completion:*:manuals' separate-sections true
zstyle ':completion:*:manuals.(^1*)' insert-sections true
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:matches' group 'yes'
zstyle ':completion:*:options' auto-description '%d'
zstyle ':completion:*:options' description 'yes'
zstyle ':completion:*:rm:*' file-patterns '*:all-files'
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
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors 'reply=( "=(#b)(*$VAR)(?)*=00=$color[green]=$color[bg-green]" )'
zstyle ':completion:*:*:*:*:hosts' list-colors '=*=30;41'
zstyle ':completion:*:*:*:*:users' list-colors '=*=$color[green]=$color[red]'
