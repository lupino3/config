#!/bin/sh

# necessary to make chrome pick up the proxy settings stored in gconf.
export DESKTOP_SESSION=gnome

# Disable audible bell
xset -b

export GTK_IM_MODULE=xim

/usr/bin/gnome-settings-daemon &
/usr/bin/nm-applet &

# Background color
xsetroot -solid "#333333"

# Start urxvtd
urxvtd -q -f -o

# Disable touchpad
xinput set-prop 11 "Device Enabled" 0

if [[ -f .xsession-local ]]; then
    source .xsession-local
fi

exec i3 --force-xinerama
