#!/usr/bin/env bash

SCRIPTNAME="$(basename $0)"
SCRIPTDIR="$(dirname "${BASH_SOURCE[0]}")"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# @Author      : Jason
# @Contact     : casjaysdev@casjay.net
# @File        : build
# @Created     : Mon, Dec 31, 2019, 00:00 EST
# @License     : WTFPL
# @Copyright   : Copyright (c) CasjaysDev
# @Description : polybar with jgmenu build script
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Set functions

if [ -f /usr/local/share/CasjaysDev/scripts/functions/app-installer.bash ]; then
  . /usr/local/share/CasjaysDev/scripts/functions/app-installer.bash
elif [ -f "$HOME/.local/share/scripts/functions/app-installer.bash" ]; then
  . "$HOME/.local/share/scripts/functions/app-installer.bash"
else
  mkdir -p "$HOME/.local/share/scripts/functions"
  curl -LSs https://github.com/dfmgr/installer/raw/main/functions/app-installer.bash -o "$HOME/.local/share/scripts/functions/app-installer.bash"
  . "$HOME/.local/share/scripts/functions/app-installer.bash"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

sudoask

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# requires
if cmd_exists apt-get; then
  if cmd_exists pkmgr; then
    for pkg in libxml2-dev libmenu-cache-dev lxmenu-data libpango1.0-dev librsvg2-dev libcairo2-dev libxrandr-dev build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev; do
      execute "pkmgr install -y $pkg" "Installing $pkg"
    done
  fi

elif cmd_exists dnf; then
  if cmd_exists pkmgr; then
    for pkg in cairo-devel xcb-util-devel libxcb-devel xcb-proto xcb-util-image-devel xcb-util-wm-devel; do
      execute "pkmgr install -y $pkg" "Installing $pkg"
    done
  fi

elif cmd_exists yum; then
  if cmd_exists pkmgr; then
    for pkg in cairo-devel xcb-util-devel libxcb-devel xcb-proto xcb-util-image-devel xcb-util-wm-devel; do
      execute "pkmgr install -y $pkg" "Installing $pkg"
    done
  fi
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
polybar_compile() {
  if ! cmd_exists polybar; then
    if [ -d "$HOME/.local/tmp/polybar" ]; then
      cd "$HOME/.local/tmp/polybar"
      git pull
    else
      git clone --recursive https://github.com/polybar/polybar "$HOME/.local/tmp/polybar"
      cd "$HOME/.local/tmp/polybar"
    fi
    mkdir build
    cd build
    cmake ..
    make -j$(nproc)
    sudo make install
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

jgmenu_compile() {
  if ! cmd_exists jgmenu; then
    if [ -d "$HOME/.local/tmp/jgmenu" ]; then
      cd "$HOME/.local/tmp/jgmenu"
      git pull
    else
      git clone --recursive https://github.com/johanmalm/jgmenu "$HOME/.local/tmp/jgmenu"
      cd "$HOME/.local/tmp/jgmenu"
    fi
    ./configure --prefix=/usr/local --with-lx --with-pmenu
    make
    sudo make install
  fi
}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

execute \
  "polybar_compile" \
  "Compiling polybar"

execute \
  "jgmenu_compile" \
  "Compiling jgmenu"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if cmd_exists polybar; then
  printf_green "\t\tpolybar has been installed\n"
else
  printf_red "\t\tpolybar has failed to build\n"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

if cmd_exists jgmenu; then
  printf_green "\t\tjgmenu has been installed\n"
else
  printf_red "\t\tjgmenu has failed to build\n"
fi

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# end
#/* vim: set expandtab ts=4 noai
