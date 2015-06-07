#!/bin/bash

isEnabled=`xinput list-props 12 |grep "Device Enabled" | awk '{print $4}'`
newState=$((${isEnabled}^1))

case "$newState" in
0 ) echo "Touchpad disabled..." 
    notify-send "Touchpad disabled" ;;
1 ) echo "Touchpad enabled..." 
    notify-send "Touchpad enabled" ;;
esac


`echo 'xinput set-prop 12 135 ' $newState`
