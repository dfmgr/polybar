#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(dirname "${BASH_SOURCE[0]}")"
USER="${SUDO_USER:-${USER}}"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : calc
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : calculator wrapper for qalc
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if [ -e "/usr/local/bin/dmenupass" ]; then
  SUDO_ASKPASS="/usr/local/bin/dmenupass}"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

[ ! -d "$HOME/.local/tmp" ] || mkdir -p  "$HOME/.local/tmp"
[ ! -f "$HOME/.local/tmp/update_check" ] || rm -Rf "$HOME/.local/tmp/update_check"

# run
#Arch update check
if [ -f /usr/bin/pacman ]; then
    if ! updates_arch=$(checkupdates 2> /dev/null | wc -l ); then
    updates_arch=0
    fi
    #yay doesn't do sudo
    if [ -f /usr/bin/yay ]; then
       if ! updates_aur=$(yay -Qum 2> /dev/null | wc -l); then
       updates_aur=0
       fi
    fi
    updates=$(("$updates_arch" + "$updates_aur"))

#Debian update check
elif [ -f /usr/bin/apt ]; then
    if ! updates=$(sudo apt-get update > /dev/null && apt-get --just-print upgrade | grep "Inst " | wc -l); then
    updates=0
    fi

elif [ -f /usr/bin/dnf ]; then
    if ! updates=$(sudo dnf check-update -q | grep -v Security | wc -l); then
    updates=0
    fi

elif [ -f /usr/bin/yum ]; then
    if ! updates=$(sudo yum check-update -q | grep -v Security | wc -l); then
    updates=0
    fi
fi

if [ "$updates" -gt 0 ]; then
    echo " $updates"
    if [ -f /usr/local/bin/notifications ]; then
      if [ ! -f "$HOME/.local/tmp/update_check"  ]; then
        echo "$updates" > "$HOME/.local/tmp/update_check"
          if [ ! -f "$HOME/.cache/update_check_no" ]; then
            /usr/local/bin/notifications "System Updates:" "You have $updates update[s] avaliable"
          fi
      fi
    fi
else
    echo "0"
    rm -Rf "$HOME/.local/tmp/update_check"
    exit 0
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
# vi: set expandtab ts=4 fileencoding=utf-8 filetype=sh noai
