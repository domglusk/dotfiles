# Environment Variables
#
#export LS_COLORS


export TERM=xterm-256color
export PATH=$HOME/bin:$HOME/.cargo/bin:/usr/local/bin:/usr/local/sbin:/sbin:/local/sbin:/snap/bin:$HOME/.nix-profile/bin:$PATH
export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

# Zinit Installation (if not already installed)
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
command git clone https://github.com/zdharma-continuum/zinit "$HOME/.zinit/bin" && \
print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

# Source Zinit and Load Plugins
source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zi ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
zi light trapd00r/LS_COLORS
export LS_COLORS="di=38;2;249;196;125:ln=38;2;207;142;68:so=38;2;136;190;255:pi=38;2;103;219;255:ex=38;2;255;255;255:bd=48;2;66;66;66;38;2;249;196;125:cd=48;2;66;66;66;38;2;249;196;125:su=38;2;239;83;80:sg=38;2;239;83;80:tw=48;2;66;66;66;38;2;103;219;255:ow=48;2;66;66;66;38;2;103;219;255"
# export LS_COLORS='di=38;2;248;248;242:ln=38;2;139;233;253:so=38;2;139;233;253:pi=38;2;139;233;253:ex=38;2;173;219;103:bd=38;2;248;248;242:cd=38;2;248;248;242:su=38;2;255;121;198:sg=38;2;255;121;198:tw=38;2;255;121;198:ow=38;2;255;121;198:st=38;2;255;121;198:mi=38;2;248;248;242:fi=38;2;248;248;242:rs=0:or=0:mi=00:*.rpm=38;2;173;219;103:*.deb=38;2;173;219;103:*.tar=38;2;173;219;103:*.zip=38;2;173;219;103:*.7z=38;2;173;219;103:*.rar=38;2;173;219;103:*.jpg=38;2;255;152;128:*.jpeg=38;2;255;152;128:*.png=38;2;173;219;103:*.gif=38;2;255;152;128:*.mp3=38;2;173;219;103:*.ogg=38;2;173;219;103:*.wav=38;2;173;219;103:*.mp4=38;2;173;219;103:*.avi=38;2;173;219;103:*.mkv=38;2;173;219;103:*.pdf=38;2;255;121;198:*.doc=38;2;255;121;198:*.txt=38;2;248;248;242:*.md=38;2;248;248;242:*.html=38;2;255;121;198:*.css=38;2;173;219;103:*.js=38;2;255;121;198:*.py=38;2;173;219;103:*.c=38;2;173;219;103:*.cpp=38;2;173;219;103:*.h=38;2;173;219;103:*.hpp=38;2;173;219;103:*.sh=38;2;255;152;128:*.zsh=38;2;255;152;128:*.bash=38;2;255;152;128:*.git=38;2;255;121;198'
zinit ice wait"0" lucid
zinit load zdharma-continuum/zui
zinit load mafredri/zsh-async
zinit ice wait lucid
zinit load tinted-theming/base16-shell
export BASE16_THEME=catppuccin-mocha
zi as'completion' for OMZP::{'golang/_golang','pip/_pip','terraform/_terraform'}
zi for is-snippet \
  OMZL::{'clipboard','compfix','completion','git','grep','key-bindings'}.zsh \
  OMZP::brew \
  PZT::modules/{'history','rsync','terminal','environment','ssh'}
zi ice svn 
zinit snippet OMZL::
# zinit snippet OMZL::git.zsh
# zinit snippet OMZL::theme-and-appearance.zsh
# #zinit snippet OMZL::termsupport.zsh
# zinit for OMZL::prompt_info_functions.zsh OMZT::pygmalion-virtualenv
if [ -e /usr/bin/zypper ]; then
  zinit snippet OMZL::git.zsh
  zinit snippet OMZL::theme-and-appearance.zsh
  zinit for OMZL::prompt_info_functions.zsh OMZT::pygmalion-virtualenv
  zinit snippet OMZ::plugins/git/git.plugin.zsh
else
  eval "$(oh-my-posh init zsh --config ~/.cache/oh-my-posh/themes/negligible.omp.json)"
fi
zinit wait lucid for \
atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
zdharma-continuum/fast-syntax-highlighting \
blockf \
clarketm/zsh-completions \
MenkeTechnologies/zsh-more-completions \
atload"!_zsh_autosuggest_start" \
zsh-users/zsh-autosuggestions

zinit load 3v1n0/zsh-bash-completions-fallback
zinit load antonjs/zsh-gpt
zinit load Licheam/zsh-ask
zinit load zdharma-continuum/zui
zinit light-mode for \
  zdharma-continuum/zinit-annex-meta-plugins \
  zdharma-continuum/zinit-annex-rust \
  zdharma-continuum/zinit-annex-as-monitor \
  zdharma-continuum/zinit-annex-patch-dl \
  zdharma-continuum/zinit-annex-bin-gem-node

zinit light zdharma-continuum/zinit-annex-meta-plugins
zinit light-mode for \
  annexes \
  annexes+con \
  molovo

zinit load Aloxaf/fzf-tab
zi wait lucid for z-shell/zi-console
zinit ice nocompile
zinit load z-shell/zsh-lsd

zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-expand
zinit load NICHOLAS85/z-a-eval
zinit ice wait"2" pick"h.sh" lucid
zinit load paoloantinori/hhighlighter
zinit ice lucid nocompile
zinit load lincheney/fzf-tab-completion

zstyle ':completion:*' fzf-search-display true
zstyle ':completion::*:ls::*' fzf-completion-opts --preview='eval head {1}'

# preview when completing env vars (note: only works for exported variables)
# eval twice, first to unescape the string, second to expand the $variable
zstyle ':completion::*:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-completion-opts --preview='eval eval echo {1}'

# preview a `git status` when completing git add
zstyle ':completion::*:git::git,add,*' fzf-completion-opts --preview='git -c color.status=always status --short'

# if other subcommand to git is given, show a git diff or git log
zstyle ':completion::*:git::*,[a-z]*' fzf-completion-opts --preview='
eval set -- {+1}
for arg in "$@"; do
    { git diff --color=always -- "$arg" | git log --color=always "$arg" } 2>/dev/null
done'
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
# Additional Configurations

# Pyenv Configuration
if [ -e ~/.pyenv ]; then
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
export PIP_BREAK_SYSTEM_PACKAGES=1
fi
# Command Not Found Setup (if available)
if [ -e /home/domglusk/.nix-profile/etc/profile.d/nix.sh ]; then
. /home/domglusk/.nix-profile/etc/profile.d/nix.sh
fi

if [ -e /etc/command_not_found ]; then
source /etc/command_not_found
fi
# History and Autocompletion Settings
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt MENU_COMPLETE
setopt COMPLETE_IN_WORD
setopt AUTO_LIST
setopt GLOB_COMPLETE
unsetopt MENU_COMPLETE
#zstyle ':completion:*:*:*:*:descriptions' format '%F{green}-- %d --%f'
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' complete true
zstyle ':completion:*:alias-expension:*' completer _expand_alias
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort name
#zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
#zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
#zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
#zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
zstyle ':completion:*' group-name ''

# Base16 Shell Setup (if available)
# Base16 Shell
BASE16_SHELL_PATH="$HOME/.config/base16-shell"
[ -n "$PS1" ] && \
  [ -s "$BASE16_SHELL_PATH/profile_helper.sh" ] && \
    source "$BASE16_SHELL_PATH/profile_helper.sh"
# Aliases
alias ls="lsd -a"
alias git-pull-all="find . -name ".git" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} reset --hard && find. -name ".git" -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull"
alias upall="sudo zypper dup --allow-vendor-change -l -y --details --force-resolution --replacefiles ; flatpak update -y ; git-pull-all ; git-pull-all-safe"
alias ksu="pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY KDE_SESSION_VERSION=5 KDE_FULL_SESSION=true"
alias xterm="konsole"
alias -g lsd="lsd -a"
alias nvidia-powerstate="cat /sys/bus/pci/devices/0000:01:00.0/power/runtime_status"
alias nvidia-modeset-test="sudo cat /sys/module/nvidia_drm/parameters/modeset"
alias colorls="lsd -a"
alias my-ip="wget -qO- https://ipecho.net/plain ; echo"
alias shizuki="adb shell sh /storage/emulated/0/Android/data/moe.shizuku.privileged.api/start.sh"
alias save-kde-session="qdbus org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.saveCurrentSession"
alias topgrade="topgrade -y --no-retry"
alias locate="plocate"
alias se='__a(){
local query="$*"
flatpak search "${query}"
echo
zypper se --provides -s  "${query}" | grep -v 'srcpackage'
echo
snap search "${query}"
unset query
}; __a'
alias pip-upgrade="pip list --outdated | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U"

# Main Commands (add your own)
alias ezsh="exec zsh"
alias yuzu="flatpak run org.yuzu_emu.yuzu"
alias retroarch="flatpak run org.libretro.RetroArch"
alias flatseal="flatpak run com.github.tchx84.Flatseal"
alias discord="flatpak run de.shorsh.discord-screenaudio"
alias catridges="flatpak run hu.kramo.Cartridges"
alias stremio="flatpak run com.stremio.Stremio"
alias geeqie="flatpak run org.geeqie.Geeqie"
#Main commands
if [ -e /usr/bin/zypper ]; then
alias z='sudo zypper'
alias zh='zypper -h'
alias zhse='zypper -h se'
alias zlicenses='zypper licenses'
alias zps='sudo zypper ps'
alias zshell='sudo zypper shell'
alias zsource-download='sudo zypper source-download'
alias ztos='zypper tos'
alias zvcmp='zypper vcmp'

#Packages commands
alias zin='sudo zypper --no-refresh in'
alias zinr='sudo zypper inr'
alias zrm='sudo zypper rm'
alias zsi='sudo zypper si'
alias zve='sudo zypper ve'

#Updates commands
alias zdup='sudo zypper dup'
alias zlp='zypper lp'
alias zlu='zypper lu'
alias zpchk='sudo zypper pchk'
alias zup='sudo zypper up'
alias zpatch='sudo zypper patch'

#Request commands
alias zif='zypper --no-refresh if'
alias zpa='zypper --no-refresh pa'
alias zpatch-info='zypper --no-refresh patch-info'
alias zpattern-info='zypper --no-refresh pattern-info'
alias zproduct-info='zypper --no-refresh product-info'
alias zpch='zypper --no-refresh pch'
alias zpd='zypper --no-refresh pd'
alias zpt='zypper --no-refresh pt'
alias zse='zypper --no-refresh se --provides -f'
alias zwp='zypper --no-refresh wp'

#Repositories commands
alias zar='sudo zypper ar'
alias zcl='sudo zypper clean'
alias zlr='zypper lr'
alias zmr='sudo zypper mr'
alias znr='sudo zypper nr'
alias zref='sudo zypper ref'
alias zrr='sudo zypper rr'

#Services commands
alias zas='sudo zypper as'
alias zms='sudo zypper ms'
alias zrefs='sudo zypper refs'
alias zrs='sudo zypper rs'
alias zls='zypper ls'

#Package Locks Management commands
alias zal='sudo zypper al'
alias zcl='sudo zypper cl'
alias zll='zypper ll'
alias zrl='sudo zypper rl'
alias zypclean="zypper packages --unneeded | awk -F'|' 'NR==0 || NR==1 || NR==2 || NR==3 || NR==4 {next} {print $3}'| grep -v Name | sudo xargs zypper remove --clean-deps"
fi

alias git-pull-all-safe="find . -name .git -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} & find . -name .git -type d | sed 's/\/.git//' |  xargs -P10 -I{} git -C {} pull"
alias speedtest="speedtest-cli --bytes --secure"


eval $(thefuck --alias)
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
typeset -ga mylogs
zflai-msg() { mylogs+=( "$1" ); }
zflai-assert() { mylogs+=( "$4"${${${1:#$2}:+FAIL}:-OK}": $3" ); }

autoload up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -v
[[ -n "$terminfo[kpp]"   ]] && bindkey "$terminfo[kpp]"   up-line-or-beginning-search   # PAGE UP
[[ -n "$terminfo[knp]"   ]] && bindkey "$terminfo[knp]"   down-line-or-beginning-search # PAGE DOWN
[[ -n "$terminfo[khome]" ]] && bindkey "$terminfo[khome]" beginning-of-line             # HOME
[[ -n "$terminfo[kend]"  ]] && bindkey "$terminfo[kend]"  end-of-line                   # END
[[ -n "$terminfo[kdch1]" ]] && bindkey "$terminfo[kdch1]" delete-char                   # DELETE
[[ -n "$terminfo[kbs]"   ]] && bindkey "$terminfo[kbs]"   backward-delete-char          # BACKSPACE

zflai-assert "${+terminfo[kpp]}${+terminfo[knp]}${+terminfo[khome]}${+terminfo[kend]}" "1111" "terminfo test" "[zshrc] "

bindkey "^A"      beginning-of-line     "^E"      end-of-line
bindkey "^?"      backward-delete-char  "^H"      backward-delete-char
bindkey "^W"      backward-kill-word    "\e[1~"   beginning-of-line
bindkey "\e[7~"   beginning-of-line     "\e[H"    beginning-of-line
bindkey "\e[4~"   end-of-line           "\e[8~"   end-of-line
bindkey "\e[F"    end-of-line           "\e[3~"   delete-char
bindkey "^J"      accept-line           "^M"      accept-line
bindkey "^T"      accept-line           "^R"      history-incremental-search-backward
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' _atuin_search_widget
bindkey '^[[A' _atuin_search_widget
bindkey '^[OA' _atuin_search_widget
