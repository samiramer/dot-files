userresources=$HOME/.Xresources

if [ -f $userresources ]; then
	xrdb -merge $userresources
fi

# Make sure dbus is activated.  For gnome-keyring.
systemctl --user import-environment DISPLAY XAUTHORITY

if which dbus-update-activation-environment >/dev/null 2>&1; then
        dbus-update-activation-environment DISPLAY XAUTHORITY
fi

# Start polkit agent
#/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &

xset r rate 200 40

if [ -x "$(command -v xss-lock)" ]; then
  xss-lock --transfer-sleep-lock -- i3lock -i ~/.config/wallpaper/blurred-wall.png &
fi

if [ -x "$(command -v xautolock)" ]; then
  xautolock -detectsleep \
    -corners -000 \
    -time 10 -locker "i3lock -i ~/.config/wallpaper/blurred-wall.png" \
    -notify 120 -notifier "xset dpms force off" \
    -killtime 20 -killer "systemctl suspend" &
fi

if [ -x "$(command -v feh)" ]; then
  feh --no-fehbg --bg-scale ~/.config/wallpaper/wall.png &
fi

# if [ -x "$(command -v video_background)" ]; then
#   video_background ~/.config/wallpaper/dubai_sunset.mp4 &
# fi

if [ -x "$(command -v blueman-applet)" ]; then
	blueman-applet &
fi

if [ -x "$(command -v nm-applet)" ]; then
	nm-applet &
fi

if [ -x "$(command -v dwmblocks)" ]; then
	dwmblocks &
fi

if [ -x "$(command -v picom)" ]; then
	picom &
fi

if [ -x "$(command -v dunst)" ]; then
	dunst &
fi

if [ -x "$(command -v redshift-gtk)" ]; then
  redshift-gtk &
fi

if [ -x "$(command -v 1password)" ]; then
  1password --silent &
fi

exec dwm
