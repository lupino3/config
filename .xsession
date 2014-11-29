#!/bin/sh

# necessary to make chrome pick up the proxy settings stored in gconf.
export DESKTOP_SESSION=gnome

# Disable audible bell
xset -b

export GTK_IM_MODULE=xim

# /usr/libexec/cinnamon-settings-daemon &
/usr/bin/nm-applet &

# Background color
xsetroot -solid "#333333"

# Disable touchpad
# xinput set-prop 11 "Device Enabled" 0

if [[ -x ~/.xsession-local ]]; then
    source ~/.xsession-local
fi

exec i3 --force-xinerama
