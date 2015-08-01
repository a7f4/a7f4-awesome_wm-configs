#!/bin/bash
touchPadID=`xinput list|grep TouchPad | \
    awk '{print $6}' | \
    awk -F "=" '{print $2}'`

isEnabled=`xinput list-props $touchPadID |grep "Device Enabled" | awk '{print $4}'`
newState=$((${isEnabled}^1))

case "$newState" in
0 ) echo "Touchpad disabled..." 
    notify-send "Touchpad disabled " ;;
1 ) echo "Touchpad enabled..." 
    notify-send "Touchpad enabled" ;;
esac


`echo 'xinput set-prop ' $touchPadID ' 135 ' $newState`
