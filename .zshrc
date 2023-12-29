#export SHELL=/usr/bin/fish
#exec fish
# === ZINIT ============================================
ZPFX="$HOME/.local"
typeset -A ZINIT
ZINIT[MAN_DIR]="$ZPFX/share/man"
XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
if [[ -f $XDG_DATA_HOME/zinit/plugins/zinit/zinit.zsh ]]; then
  . $XDG_DATA_HOME/zinit/plugins/zinit/zinit.zsh
elif (($+commands[git])); then
  git clone --depth=1 https://github.com/zdharma-continuum/zinit \
    $XDG_DATA_HOME/zinit/plugins/zinit
  . $XDG_DATA_HOME/zinit/plugins/zinit/zinit.zsh
else
  return
fi
zinit load wbingli/zsh-wakatime
# zinit load chrissicool/zsh-256color
zinit lucid for  \
  OMZL::clipboard.zsh \
  OMZL::spectrum.zsh \
  OMZL::termsupport.zsh \
  OMZP::sudo

zinit id-as'.vivid' depth'1' wait lucid \
  atclone'echo "export LS_COLORS=\"$(vivid generate $vivid_theme)\"" > vivid.sh
  zcompile *.sh' \
  atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"' \
  if'(($+commands[vivid]))' \
  for zdharma-continuum/null

zinit load aubreypwd/zsh-plugin-require
zinit load mdumitru/last-working-dir
zinit ice lucid nocompile
zinit load MenkeTechnologies/zsh-learn
zinit wait lucid for \
  zpm-zsh/undollar \
  Licheam/zsh-ask \
  sobolevn/wakatime-zsh-plugin \
  zpm-zsh/ssh \
  zpm-zsh/colors \
  zpm-zsh/colorize \
  zpm-zsh/dircolors-neutral \
  Sam-programs/zsh-calc \
  mroth/evalcache \

zinit wait lucid as"program" pick"aish" for chr15m/aish
#zinit wait lucid for \
# has'eza' atinit'AUTOCD=1' \
#   z-shell/zsh-eza
zinit ice at init''
zinit load tom-doerr/zsh_codex
create_completion () {
text=${BUFFER}
completion=$(echo -n "$text" | $HOME/.local/share/zinit/plugins/tom-doerr---zsh_codex/create_completion.py $CURSOR)
text_before_cursor=${text:0:$CURSOR}
text_after_cursor=${text:$CURSOR}
BUFFER="${text_before_cursor}${completion}${text_after_cursor}"
prefix_and_completion="${text_before_cursor}${completion}"
CURSOR=${#prefix_and_completion}
}

zinit ice wait"2" lucid
zinit load zdharma-continuum/declare-zsh
zinit ice wait"1" lucid
zinit load zdharma-continuum/zui
#
# zinit ice lucid wait"1"
#   zinit load \
# marlonrichert/zsh-autocomplete


zinit ice wait'[[ -n ${ZLAST_COMMANDS[(r)cra*]} ]]' lucid
zinit load zdharma-continuum/zinit-crasis


zinit load atuinsh/atuin
zinit id-as depth'1' wait lucid for Freed-Wu/zsh-help
zinit id-as depth'1' wait lucid for Freed-Wu/zsh-colorize-functions
zinit id-as depth'1' wait lucid for zpm-zsh/colorize
zinit id-as depth'1' wait lucid \
  if'(($+commands[mysql]))' \
  for zpm-zsh/mysql-colorize
# 1}}} Colorize #

# Function {{{1 #
zinit id-as depth'1' wait lucid \
  if'(($+commands[xdg-open] || $+commands[open]))' \
  for sineto/web-search
# 1}}} Function #

# Compatible {{{1 #
zinit id-as depth'1' wait lucid for Freed-Wu/zsh-completions-for-cross-compilers



# revolver
zinit ice wait"2" lucid as"program" pick"revolver"
zinit load zdharma-continuum/revolver

zinit light-mode for zdharma-continuum/zinit-annex-as-monitor zdharma-continuum/zinit-annex-bin-gem-node zdharma-continuum/zinit-annex-patch-dl zdharma-continuum/zinit-annex-rust

zinit sbin'bin/zsweep' for @psprint/zsh-sweep
zinit ice wait lucid load z-shell/zsh-lint
zinit ice wait"1" lucid load z-shell/zsh-fancy-completions
#zinit ice wait"1" lucid nocompile
#zinit load z-shell/zsh-lsd

# zinit ice lucid nocompile wait'0f' nocompletions
#     zinit load \
#         MenkeTechnologies/zsh-more-completions

zinit ice wait"1" pick"h.sh" lucid
zinit load paoloantinori/hhighlighter

zinit for \
    from'gh-r' \
    sbin'**/sh* -> shfmt' \
  @mvdan/sh

[ -f ~/.local/share/fzf-help/fzf-help.zsh ] || { tmp_dir=$(mktemp -d); git clone https://github.com/BartSte/fzf-help.git $tmp_dir; $tmp_dir/install --user; rm -rf $tmp_dir; }
source $HOME/.local/share/fzf-help/fzf-help.zsh
zle -N fzf-help-widget
bindkey "^[a" fzf-help-widget



zinit ice lucid depth"1" blockf
zinit load yuki-yano/zeno.zsh

zinit load zdharma-continuum/zinit-annex-meta-plugins
zinit ice wait lucid load annexes+con
# Download the default profile
#zinit pack for dircolors-material

# Download the Node package of remark-cli, remark-man and remark-html
 zinit pack for remark


# zinit pack for zsh
#
zinit ice \
  bindmap"^B -> ^H" \
  lucid \
  trackbinds \
  wait"3"
[ -z "$HISTFILE" ] && HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=$HISTSIZE

#zinit ice lucid nocompile
#zinit load MenkeTechnologies/zsh-expand

compdef _gnu_generic ffmpeg ffplay ffprobe file
# https://github.com/3v1n0/zsh-bash-completions-fallback/issues/6
compdef _python python
compdef _pydoc pydoc
compdef _pip pip
# after compinit
zinit id-as depth'1' wait lucid for 3v1n0/zsh-bash-completions-fallback
zinit id-as depth'1' null for zdharma-continuum/zinit



if [ -e /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
fi

zinit load Freed-Wu/zsh-command-not-found

# bindkey -e
# export ATUIN_NOBIND="true"
# eval "$(atuin init zsh)"
# bindkey '^r' _atuin_search_widget
# bindkey '^[[A' _atuin_search_widget
# bindkey '^[OA' _atuin_search_widget
# if [ -e ~/pygmalion-posh.omp.json ]; then
#    eval "$(oh-my-posh init zsh --config ~/pygmalion-posh.omp.json)"

zinit ice atinit"ZSH_THEME=pygmalion-virtualenv"
zinit load zshzoo/omz-themes-standalone
# else
#zinit ice as"command" from"gh-r" \
#        atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
#        atpull"%atclone" src"init.zsh"
#zinit load starship/starship
# fi
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
  if [ -e ~/.nix-profile/bin/carapace ]; then
 source <(carapace _carapace zsh)

fi
# source <(cod init $$ zsh)
# Pyenv Configuration
if [ -e ~/.pyenv ]; then
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
fi
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.


# autoload -U add-zsh-hook                      # Load the zsh hook module.
# add-zsh-hook preexec pre_validation
export HIST_IGNORE_SPACE=1

# Key Bindings
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^[[A' _atuin_search_widget
bindkey '^[OA' _atuin_search_widget

bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^[[C' forward-char
bindkey '^[[D' backward-char
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^M' accept-line
bindkey '^D' delete-char-or-list
bindkey '^C' send-break
bindkey '^Z' push-line
bindkey '^L' clear-screen
bindkey -e
bindkey '^X' create_completion
# function ya() {
# 	tmp="$(mktemp -t "yazi-cwd.XXXXX")"
# 	yazi "$@" --cwd-file="$tmp"
# 	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
# 		cd -- "$cwd"
# 	fi
# 	rm -f -- "$tmp"
# }
# fastfetch



# Hishtory Config:
#export PATH="$PATH:/home/domglusk/.hishtory"
#source /home/domglusk/.hishtory/config.zsh
#export SHELL=/usr/bin/fish

#exec fish

# argc-completions
#export ARGC_COMPLETIONS_ROOT="/home/domglusk/.gtclone/argc-completions"
#export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions"
#export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"
# To add a subset of completions only, change next line e.g. argc_scripts=( cargo git )
#argc_scripts=( $(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p') )
#source <(argc --argc-completions zsh $argc_scripts)

zinit lucid wait for \
  atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit;
  zicdreplay" \
      z-shell/F-Sy-H \

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
      zsh-users/zsh-completions \
      zchee/zsh-completions \
      clarketm/zsh-completions \
      nix-community/nix-zsh-completions \
      petronny/pinyin-completion \
      sambergo/zsh-prettier-completion \
      corvofeng/joe-completion \
      grigorii-zander/zsh-npm-scripts-autocomplete \
      Yash-Singh1/zsh-plugin-speedtest \
      MenkeTechnologies/zsh-more-completions

ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line vi-add-eol)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(vi-find-next-char
  forward-char vi-forward-char forward-word emacs-forward-word
  vi-forward-word vi-forward-word-end vi-forward-blank-word
  vi-forward-blank-word-end vi-find-next-char vi-find-next-char-skip
)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=(yank yank-pop
  history-search-forward history-search-backward
  history-beginning-search-forward history-beginning-search-backward
  history-substring-search-up history-substring-search-down
  up-line-or-beginning-search down-line-or-beginning-search
  up-line-or-history down-line-or-history accept-line copy-earlier-word
  )
ZSH_AUTOSUGGEST_IGNORE_WIDGETS=(
  orig-\*
  beep
  run-help
  set-local-history
  which-command
  zle-\*
)
zinit id-as depth'1' wait lucid \
  atload'_zsh_autosuggest_start
  bindkey "^\\" autosuggest-toggle' \
  for zsh-users/zsh-autosuggestions

zinit wait lucid nocd depth=1 \
  atinit='ZSH_BASH_COMPLETIONS_FALLBACK_LAZYLOAD_DISABLE=true' \
  for 3v1n0/zsh-bash-completions-fallback

FZF_TMUX_HEIGHT=$((LINES - 1))
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' single-group prefix color header
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-_'
zstyle ':fzf-tab:*' switch-group 'alt-,' 'alt-.'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
 ¦ '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zinit id-as depth'1' wait lucid \
  if'(($+commands[fzf]))' \
  for jdujava/fzf-tab-jd

zinit id-as depth'1' lucid \
  if'(($+commands[fzf]))' \
  for Freed-Wu/fzf-tab-source

zinit light-mode wait lucid for pschmitt/emoji-fzf.zsh
source $HOME/.zshaliases
