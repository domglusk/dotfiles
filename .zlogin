# For login shells. Basically the same as .zprofile except that it's sourced AFTER .zshrc
# Execute code that does not affect the current session in the background.

{
  # Compile the completion dump to increase startup speed.
  zcompdump="${ZDOTDIR:-$HOME}/.zcompdump"
  if [[ -s "$zcompdump" && (! -s "${zcompdump}.zwc" || "$zcompdump" -nt "${zcompdump}.zwc") ]]; then
    zcompile "$zcompdump"
  fi
} &!

# shellcheck disable=all
# Add ~/.nix-profile/bin to $PATH
if [[ -f ~/.nix-profile/etc/profile.d/nix.sh ]]; then
	. ~/.nix-profile/etc/profile.d/nix.sh
fi
# for tty
if [[ -f ~/.xprofile ]] && ((! $+PYTHONSTARTUP)); then
	. ~/.xprofile
fi
if [[ -f ~/.bash_profile ]] && ((! $+DOCKER_BUILDKIT)); then
	. ~/.bash_profile
fi
if [[ -f ~/.local/share/zinit/plugins/.pass/pass.sh ]]; then
	. ~/.local/share/zinit/plugins/.pass/pass.sh
fi
# NixOS
if [[ -d /run/current-system/sw/share ]] &&
	[[ ${XDG_DATA_DIRS#/run/current-system/sw/share:} == $XDG_DATA_DIRS ]]; then
	XDG_DATA_DIRS="/run/current-system/sw/share${XDG_DATA_DIRS+:}$XDG_DATA_DIRS"
fi
if [[ -z $C6X_C_DIR && -f ~/.bash_login ]]; then
	. ~/.bash_login
fi
#===# From Freed-Wu
