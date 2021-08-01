## polybar  
  
fast and easy-to-use tool for creating status bars  
  
Automatic install/update:

```shell
bash -c "$(curl -LSs https://github.com/dfmgr/polybar/raw/main/install.sh)"
```

Manual install:
  
requires:

Debian based:

```shell
apt install libxcb-xkb-dev libxcb-xrm-dev libxcb-cursor-dev libasound2-dev libpulse-dev i3-wm libjsoncpp-dev libmpdclient-dev libcurl4-openssl-dev libnl-genl-3-dev build-essential git cmake cmake-data pkg-config python3-sphinx libcairo2-dev libxcb1-dev libxcb-util0-dev libxcb-randr0-dev libxcb-composite0-dev python-xcbgen xcb-proto libxcb-image0-dev libxcb-ewmh-dev libxcb-icccm4-dev
cd "$HOME/.config/polybar" && ./build.sh
```  

Fedora Based:

```shell
yum install xcb-util-xrm-devel xcb-util-cursor-devel alsa-lib-devel pulseaudio-libs-devel i3-ipc jsoncpp-devel libmpdclient-devel libcurl-devel wireless-tools-devel libnl3-devel cairo-devel xcb-util-devel libxcb-devel xcb-proto xcb-util-image-devel xcb-util-wm-devel
cd "$HOME/.config/polybar" && ./build.sh
```  

Arch Based:

```shell
pacman -S polybar
```  

MacOS:  

```shell
brew install 
```
  
```shell
mv -fv "$HOME/.config/polybar" "$HOME/.config/polybar.bak"
git clone https://github.com/dfmgr/polybar "$HOME/.config/polybar"
```
  
<p align=center>
  <a href="https://wiki.archlinux.org/index.php/polybar" target="_blank" rel="noopener noreferrer">polybar wiki</a>  |  
  <a href="https://github.com/jaagr/polybar" target="_blank" rel="noopener noreferrer">polybar site</a>
</p>  
