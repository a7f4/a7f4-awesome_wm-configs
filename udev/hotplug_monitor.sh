#/bin/sh
echo "Test" > /tmp/t.txt
export DISPLAY=:0
export XAUTHORITY=/home/LOGICIFY/$USERNAME/.Xauthority 

function connect(){
xrandr --output HDMI1 --auto --primary --right-of eDP1
}
 
function disconnect(){
xrandr --auto
}

echo "Test" > /tmp/t.txt

xrandr | grep "HDMI1 connected" &> /dev/null && connect || disconnect

