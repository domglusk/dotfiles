emulate sh -c 'source /etc/profile'
emulate sh -c 'source ~/.profile'
# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.nix-profile/share" ] ; then
    XDG_DATA_DIRS=$HOME/.nix-profile/share:$XDG_DATA_DIRS
fi

# set PATH so it includes user's private bin if it exists
if [ -d "/nix/var/nix/profiles/default/share" ] ; then
    XDG_DATA_DIRS=/nix/var/nix/profiles/default/share:$XDG_DATA_DIRS
fi
#if ps -e | grep -q "kmscon"; then
#tmux
#fi 
eval "$(manpager)"
export TERM=xterm-256color
