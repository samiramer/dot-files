[ -f "/opt/homebrew/bin/brew" ] && eval "$(/opt/homebrew/bin/brew shellenv)"

if [ -d "$HOME/.local/bin" ] ; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.local/scripts" ] ; then
  PATH="$HOME/.local/scripts:$PATH"
fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	# exec startx
  if uwsm check may-start; then
      exec uwsm start hyprland-uwsm.desktop
  fi
fi
