#!/bin/sh

# Necessary to make chrome pick up the proxy settings stored in gconf.
export DESKTOP_SESSION=gnome

# Disable audible bell
xset -b

export GTK_IM_MODULE=xim

# For media keys and touchpad support. Don't forget to install Cinnamon to
# make it work.
/usr/bin/cinnamon-settings-daemon &

# NetworkManager.
/usr/bin/nm-applet &

# Background color
xsetroot -solid "#333333"

if [[ -x ~/.xsession-local ]]; then
    source ~/.xsession-local
fi

exec i3 --force-xinerama
