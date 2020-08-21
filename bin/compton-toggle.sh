#!/usr/bin/env bash

# https://github.com/jaagr/polybar/wiki/User-contributed-modules

#The command for starting compton
#always keep the -b argument!

if pgrep -x "compton" > /dev/null
then
	killall compton
else
	compton -b --config $DESKTOP_SESSION_CONFDIR/compton.conf
fi
