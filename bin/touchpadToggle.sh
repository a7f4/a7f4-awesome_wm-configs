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

#turn off 'paste from clipboard' by middle button
xmodmap -e "pointer = 1 25 3 4 5 6 7 8 9"

`echo 'xinput set-prop ' $touchPadID ' 135 ' $newState`
