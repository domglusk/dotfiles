
source $HOME/.zshaliases
if [ -e ~/.zsh-dominic-ge75raider10sf ]; then
  source ~/.zsh-dominic-ge75raider10sf
fi
autoload colors && colors
if [ -e /home/domglusk/.nix-profile/etc/profile.d/nix.sh ]; then
    . /home/domglusk/.nix-profile/etc/profile.d/nix.sh
fi # added by Nix installer
if [ -n "$SSH_CONNECTION" ]; then
#  $HOME/Sync/scripts/tmux-ssh.sh
    source ~/.zshenv

fi
if [[ $TERM == "foot" ]]; then
eval "$(zellij setup --generate-auto-start zsh)"
fi
[[ -o interactive ]] || exit 0
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh
export LS_COLORS="$(vivid generate snazzy)"

zcomet load mdumitru/last-working-dir
zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

[ -f ~/.local/share/fzf-help/fzf-help.zsh ] || { tmp_dir=$(mktemp -d); git clone https://github.com/BartSte/fzf-help.git $tmp_dir; $tmp_dir/install --user; rm -rf $tmp_dir; }
source $HOME/.local/share/fzf-help/fzf-help.zsh
zle -N fzf-help-widget
bindkey "^[a" fzf-help-widget

if [ -e /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
else
  zcomet load Freed-Wu/zsh-command-not-found
fi

if [ "$ANON" -eq 1 ]; then
  ZSH_THEME="robbyrussell"
  zcomet load zshzoo/omz-themes-standalone
env () {
	command grc --colour=auto $0 "$@" | grep --color=always -v API | grep --color=always -v TOKEN
}
elif [ -e ~/pygmalion-posh.omp.json ]; then
  eval "$(oh-my-posh init zsh --config ~/pygmalion-posh.omp.json)"
else
  ZSH_THEME="pygmalion-virtualenv"
  zcomet load zshzoo/omz-themes-standalone
fi
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# Pyenv Configuration
if [ -e ~/.pyenv ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  eval "$(pyenv init --path)"
fi

# Key Bindings
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
atuin-setup() {
        if ! which atuin &> /dev/null; then return 1; fi
        bindkey '^R' _atuin_search_widget
        export ATUIN_NOBIND="true"
        eval "$(atuin init "zsh")"
        fzf-atuin-history-widget() {
            local selected num
            setopt localoptions noglobsubst noposixbuiltins pipefail no_aliases 2>/dev/null

            # local atuin_opts="--cmd-only --limit ${ATUIN_LIMIT:-5000}"
            local atuin_opts="--cmd-only"
            local fzf_opts=(
                --tac
                "-n2..,.."
                --tiebreak=index
                "--query=${LBUFFER}"
                "+m"
                "--bind=ctrl-d:reload(atuin search $atuin_opts -c $PWD),ctrl-r:reload(atuin search $atuin_opts)"
            )

            selected=$(
                eval "atuin search ${atuin_opts}" |
                    fzf "${fzf_opts[@]}"
            )
            local ret=$?
            if [ -n "$selected" ]; then
                # the += lets it insert at current pos instead of replacing
                LBUFFER+="${selected}"
            fi
            zle reset-prompt
            return $ret
        }
        zle -N fzf-atuin-history-widget
        bindkey '^R' fzf-atuin-history-widget
    }
    atuin-setup

zcomet fpath sainnhe/zsh-completions
zcomet fpath nix-community/nix-zsh-completions
zcomet fpath sambergo/zsh-prettier-completion
zcomet fpath corvofeng/joe-completion
zcomet fpath grigorii-zander/zsh-npm-scripts-autocomplete
zcomet fpath MenkeTechnologies/zsh-more-completions
zcomet fpath syohex/zsh-misc-completions
# argc-completions
export ARGC_COMPLETIONS_ROOT="/home/domglusk/.gtclone/argc-completions"
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions"
export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"
source <(argc --argc-completions zsh $argc_scripts)
 fpath=(
    $fpath
    $HOME/.local/share/zsh/generated_man_completions
 )
ZCOMET_FPATH+="$HOME/.local/share/zsh/generated_man_completions"
zstyle ':zcomet:compinit' dump-file $ZSH_CACHE_DIR/zcompdump-$HOSTNAME
zcomet compinit

ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=(end-of-line vi-end-of-line vi-add-eol)
ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=(vi-find-next-char
  forward-char vi-forward-char forward-word emacs-forward-word
  vi-forward-word vi-forward-word-end vi-forward-blank-word
  vi-forward-blank-word-end vi-find-next-char vi-find-next-char-skip
)
ZSH_AUTOSUGGEST_CLEAR_WIDGETS=+(yank yank-pop
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
zcomet load zdharma-continuum/fast-syntax-highlighting

zcomet load zsh-users/zsh-autosuggestions
zcomet load aubreypwd/zsh-plugin-require
zcomet load Licheam/zsh-ask
zcomet load zpm-zsh/ssh
zcomet load zpm-zsh/colorize
zcomet load Freed-Wu/zsh-help
zcomet load Freed-Wu/zsh-colorize-functions
zcomet load Freed-Wu/zsh-completions-for-cross-compilers
zcomet load kaplanelad/shellfirm
zcomet load wofr06/lesspipe  | source /dev/stdin
zstyle ':fzf-tab:complete:*:options' fzf-preview 
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview
 zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
  ¦ '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zcomet load pschmitt/emoji-fzf.zsh
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' single-group prefix color header
zcomet load jdujava/fzf-tab-jd
zcomet load Freed-Wu/fzf-tab-source
zcomet load 3v1n0/zsh-bash-completions-fallback

eval "$(navi widget zsh)"
_zsh_autosuggest_strategy_atuin_top() {
  suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}
ZSH_AUTOSUGGEST_STRATEGY="match_prev_cmd completion atuin"
# Delete char
bindkey '\e[3~' delete-char
# Beginning of line
bindkey '\e[1~' beginning-of-line
# End of line
bindkey '\e[4~' end-of-line
# Beginning of line (kvt)
bindkey '\e[H' beginning-of-line
# End of line (kvt)
bindkey '\e[F' end-of-line
# Beginning of line (rxvt and konsole)
bindkey '\e[7~' beginning-of-line
# End of line (rxvt and konsole)
bindkey '\e[8~' end-of-line
bindkey "^?" backward-delete-char
setopt noextendedglob
setopt no_correct


typeset -U FPATH PATH MANPATH

