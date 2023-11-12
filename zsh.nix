{programs, pkgs, zsh, ...
}: {
# programs.zsh.plugins = [
#       {
#         name = "zinit";
#         src = "${pkgs.zinit}";
#       }
# #       { name = "zsh-autocomplete";
# #       src = "${pkgs.zsh-autocomplete}";
# #       }
#       ];
      programs.zsh.enableCompletion = true;
programs.zsh.shellInit = ''
export FZF_DEFAULT_OPTS=" \
    --color=bg+:#363a4f,bg:#24273a,spinner:#f4dbd6,hl:#ed8796 \
    --color=fg:#cad3f5,header:#ed8796,info:#c6a0f6,pointer:#f4dbd6 \
    --color=marker:#f4dbd6,fg+:#cad3f5,prompt:#c6a0f6,hl+:#ed8796"
    # Environment Variables
    export STARSHIP_CONFIG=~/.config/starship.toml
    export STARSHIP_SHOW
    export TERM=xterm-256color
    export PATH=$HOME/bin:$HOME/.cargo/bin:/usr/local/bin:/usr/local/sbin:/sbin:/local/sbin:/snap/bin:$HOME/.nix-profile/bin:$PATH
    export LOCALE_ARCHIVE="$(nix-env --installed --no-name --out-path --query glibc-locales)/lib/locale/locale-archive"

#   ZINIT_HOME="$HOME/.local/share/zinit/zinit.git"
#   [ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
#   [ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
#   source "$ZINIT_HOME/zinit.zsh"
#   autoload -Uz _zinit
#   (( $+_comps )) && _comps[zinit]=_zinit
    # Source Zinit and Load Plugins
    source "${pkgs.zinit}/share/zinit/zinit.zsh"
   # zinit load tranzystorekk/zellij-zsh
    zinit ice wait"0" lucid
    zinit load zdharma-continuum/zui
    zinit load mafredri/zsh-async

    zi as'completion' for OMZP::{'golang/_golang','pip/_pip','terraform/_terraform'}
    zi for is-snippet \
      OMZL::{'clipboard','compfix','completion','git','grep','key-bindings'}.zsh \
      OMZP::brew \
      PZT::modules/{'history','rsync'}
    zi ice svn;
    zinit ice PZTM::terminal/
    zinit ice PZTM::/environment/
    zinit ice PZTM::/prompt/
    zinit ice PZTM::/ssh/

    # zinit snippet OMZL::git.zsh
    # zinit snippet OMZL::theme-and-appearance.zsh
    # #zinit snippet OMZL::termsupport.zsh
    # zinit for OMZL::prompt_info_functions.zsh OMZT::pygmalion-virtualenv
    if [ -e /usr/bin/zypper ]; then
      zinit snippet OMZL::git.zsh
      zinit snippet OMZL::theme-and-appearance.zsh
      zinit for OMZL::prompt_info_functions.zsh OMZT::pygmalion-virtualenv
      zinit snippet OMZ::plugins/git/git.plugin.zsh
    #else
    #   eval "$(oh-my-posh init zsh --config ~/.pygmalion-posh.json)"
     fi
     # Load powerlevel10k theme
    # zinit ice depth"1" # git clone depth
    # zinit light romkatv/powerlevel10k

    # Load pure theme
    # zinit ice pick"async.zsh" src"pure.zsh" # with zsh-async library that's bundled with it.
    #  zinit light sindresorhus/pure
    # zi light-mode for \
    #   compile'(pure|async).zsh' multisrc'(pure|async).zsh' atinit"
    #     zstyle ':prompt:pure:git:action' color 'yellow'
    #     zstyle ':prompt:pure:git:branch' color 'blue'
    #     zstyle ':prompt:pure:git:dirty' color 'red'
    #     zstyle ':prompt:pure:path' color 'cyan'
    #     zstyle ':prompt:pure:prompt:success' color 'green'" \
    #   sindresorhus/pure
    # #=== zsh-vim-mode cursor configuration [[[
    # MODE_CURSOR_VICMD="green block";              MODE_CURSOR_VIINS="#20d08a blinking bar"
    # MODE_INDICATOR_REPLACE='%F{9}%F{1}REPLACE%f'; MODE_INDICATOR_VISUAL='%F{12}%F{4}VISUAL%f'
    # MODE_INDICATOR_VIINS='%F{15}%F{8}INSERT%f';   MODE_INDICATOR_VICMD='%F{10}%F{2}NORMAL%f'
    # MODE_INDICATOR_VLINE='%F{12}%F{4}V-LINE%f';   MODE_CURSOR_SEARCH="#ff00ff blinking underline"
    # setopt PROMPT_SUBST;  export KEYTIMEOUT=1 export LANG=en_US.UTF-8; export LC_ALL="en_US.UTF-8";
    # export LC_COLLATE='C' export LESS='-RMs'; export PAGER=less;       export VISUAL=vi

    # Load starship theme
    # line 1: `starship` binary as command, from github release
    # line 2: starship setup at clone(create init.zsh, completion)
    # line 3: pull behavior same as clone, source init.zsh
    zinit ice as"command" from"gh-r" \
               atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
               atpull"%atclone" src"init.zsh"
     zinit light starship/starship
    zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
    z-shell/F-Sy-H \
     blockf \
    lucid \
    wait \
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

    zinit wait lucid for zdharma-continuum/zinit-console
    zinit ice nocompile
    zinit load z-shell/zsh-lsd

    zinit ice lucid nocompile
    zinit load MenkeTechnologies/zsh-expand
    zinit load NICHOLAS85/z-a-eval
    zinit ice wait"2" pick"h.sh" lucid
    zinit load paoloantinori/hhighlighter

    zi ice atclone"dircolors -b LS_COLORS > c.zsh" atpull'%atclone' pick"c.zsh" nocompile'!'
    zi light trapd00r/LS_COLORS

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
    # zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
    # zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
    # zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
    # zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

    zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
    zstyle ':completion:*' group-name
# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:complete:cd:*' popup-pad 30 0
  '';
#   symlinkJoin  {
#     name = "zsh-custom";
#     paths = [
#       programs.zsh
#     ];
#     buildInputs = [makeWrapper];
#     postBuild = ''
#       cp ${config} $out/etc/.zshrc
#       wrapProgram $out/bin/zsh --set ZDOTDIR $out/etc
#     '';
#     passthru = {
#       shellPath = "/bin/zsh";
#     };
}
