#!/usr/bin/env bash

# requires
# sudo fontmgr install awesome-terminal

# make sure a session is specified
if [ -z "$DESKTOP_SESSION" ]; then
  export DESKTOP_SESSION="${DESKTOP_SESSION}"
fi

if [ -z "$DESKTOP_SESSION_CONFDIR" ]; then
  export DESKTOP_SESSION_CONFDIR="$HOME/.config/$DESKTOP_SESSION"
fi

# setup monitors
MONITOR=$(polybar -m | tail -1 | sed -e 's/:.*$//g')

# Terminate already running bar instances
if pidof polybar; then
  killall polybar >/dev/null 2>&1
fi

desktop=$(echo $DESKTOP_SESSION)
count=$(xrandr --query 2>/dev/null | grep " connected" | cut -d" " -f1 | wc -l)

case $desktop in

i3)
  if type "xrandr" >/dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload mainbar-i3 -c ~/.config/polybar/config &
    done
  else
    polybar --reload mainbar-i3 -c ~/.config/polybar/config &
  fi
  ;;

openbox)
  if type "xrandr" >/dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload mainbar-openbox -c ~/.config/polybar/config &
    done
  else
    polybar --reload mainbar-openbox -c ~/.config/polybar/config &
  fi
  ;;

bspwm)
  if type "xrandr" >/dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
    done
  else
    polybar --reload mainbar-bspwm -c ~/.config/polybar/config &
  fi
  ;;

xmonad)
  if [ $count = 1 ]; then
    m=$(xrandr --query | grep " connected" | cut -d" " -f1)
    MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
  else
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload mainbar-xmonad -c ~/.config/polybar/config &
    done
  fi
  ;;

*)
  if type "xrandr" >/dev/null; then
    for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload mainbar-openbox -c ~/.config/polybar/config &
    done
  else
    polybar --reload mainbar-openbox -c ~/.config/polybar/config &
  fi
  ;;

esac
