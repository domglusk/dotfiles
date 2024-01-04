
if [[ ! -f ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh ]]; then
  command git clone https://github.com/agkozak/zcomet.git ${ZDOTDIR:-${HOME}}/.zcomet/bin
fi

source ${ZDOTDIR:-${HOME}}/.zcomet/bin/zcomet.zsh
zcomet load ohmyzsh plugins/sudo
zcomet load aubreypwd/zsh-plugin-require
zcomet load mdumitru/last-working-dir
zcomet load Licheam/zsh-ask
zcomet load zpm-zsh/ssh
zcomet load zpm-zsh/colors
zcomet load zpm-zsh/colorize
zcomet load tom-doerr/zsh_codex
create_completion () {
  text=${BUFFER}
  completion=$(echo -n "$text" | $HOME/.local/share/zinit/plugins/tom-doerr---zsh_codex/create_completion.py $CURSOR)
  text_before_cursor=${text:0:$CURSOR}
  text_after_cursor=${text:$CURSOR}
  BUFFER="${text_before_cursor}${completion}${text_after_cursor}"
  prefix_and_completion="${text_before_cursor}${completion}"
  CURSOR=${#prefix_and_completion}
}
zcomet load zdharma-continuum/declare-zsh
zcomet load Freed-Wu/zsh-help
zcomet load Freed-Wu/zsh-colorize-functions
zcomet load Freed-Wu/zsh-completions-for-cross-compilers

[ -f ~/.local/share/fzf-help/fzf-help.zsh ] || { tmp_dir=$(mktemp -d); git clone https://github.com/BartSte/fzf-help.git $tmp_dir; $tmp_dir/install --user; rm -rf $tmp_dir; }
source $HOME/.local/share/fzf-help/fzf-help.zsh
zle -N fzf-help-widget
bindkey "^[a" fzf-help-widget

if [ -e /etc/zsh_command_not_found ]; then
    source /etc/zsh_command_not_found
else
  zcomet load Freed-Wu/zsh-command-not-found
fi

if [ -e ~/pygmalion-posh.omp.json ]; then
  eval "$(oh-my-posh init zsh --config ~/pygmalion-posh.omp.json)"
else
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

fpath=(~/.zsh.d/ $fpath)
zcomet fpath zsh-users/zsh-completions
zcomet fpath zchee/zsh-completions
zcomet fpath clarketm/zsh-completions
zcomet fpath nix-community/nix-zsh-completions
zcomet fpath sambergo/zsh-prettier-completion
zcomet fpath corvofeng/joe-completion
zcomet fpath grigorii-zander/zsh-npm-scripts-autocomplete
zcomet fpath MenkeTechnologies/zsh-more-completions
zstyle ':zcomet:compinit' dump-file $ZSH_CACHE_DIR/zcompdump.$HOSTNAME
zcomet compinit
zcomet load zdharma-continuum/fast-syntax-highlighting
zcomet load zsh-users/zsh-autosuggestions

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

zcomet load 3v1n0/zsh-bash-completions-fallback
FZF_TMUX_HEIGHT=$((LINES - 1))
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':fzf-tab:*' prefix ''
zstyle ':fzf-tab:*' single-group prefix color header
zstyle ':fzf-tab:*' continuous-trigger 'ctrl-_'
zstyle ':fzf-tab:*' switch-group 'alt-,' 'alt-.'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' \
	fzf-preview 'echo ${(P)word}'
zstyle ':fzf-tab:complete:tldr:argument-1' fzf-preview 'tldr --color always $word'
zstyle ':fzf-tab:complete:(\\|)run-help:*' fzf-preview 'run-help $word'
zstyle ':fzf-tab:complete:(\\|*/|)man:*' fzf-preview 'man $word'
zstyle ':fzf-tab:complete:-command-:*' fzf-preview \
 ¦ '(out=$(tldr --color always "$word") 2>/dev/null && echo $out) || (out=$(MANWIDTH=$FZF_PREVIEW_COLUMNS man "$word") 2>/dev/null && echo $out) || (out=$(which "$word") && echo $out) || echo "${(P)word}"'
zcomet load jdujava/fzf-tab-jd

zcomet load Freed-Wu/fzf-tab-source

source $HOME/.zshaliases
if [ -n "$SSH_CONNECTION" ]; then
  $HOME/Sync/scripts/tmux-ssh.sh
fi
eval "$(navi widget zsh)"
_zsh_autosuggest_strategy_atuin_top() {
  suggestion=$(atuin search --cmd-only --limit 1 --search-mode prefix $1)
}
ZSH_AUTOSUGGEST_STRATEGY=atuin_top
