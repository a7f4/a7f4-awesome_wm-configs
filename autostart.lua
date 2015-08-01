local helpers = require("helpers")

-- Start screen sever daemon
-- helpers.run_once("gnome-screensaver")

awful.util.spawn(bitstamp)

-- Setup keyboard delay
os.execute("xset r rate 220 30")

-- disable middle button for paste 
os.execute("xinput set-button-map 13 1 0 3 4 5 6 7")

-- Setup default brightness
os.execute("xbacklight", "-set 15")
--
-- Setup keyboard layout
helpers.run_once("setxkbmap", "-option grp:caps_toggle \"us,ru\"")
--
-- Mail client
helpers.run_once("thunderbird")

-- CopyQ - clipboard manager
helpers.run_once("copyq")

-- Keyboard layout indicator
os.execute("pkill xxkb")
helpers.run_once("xxkb")


-- Time tracker
os.execute("pkill hamster-indicat")
helpers.run_once("hamster-indicator")


-- Skype
helpers.run_once("skype")

-- Network Manager
helpers.run_once("nm-applet")

-- Volume control icone
helpers.run_once("volumeicon")

-- Power manager
helpers.run_once("xfce4-power-manager")

-- Application launcher
--helpers.run_once("synapse", "-s")

-- Enable numlock
-- helpers.run_once("numlockx", "on")

-- Apply Fix for desktop java apps
helpers.run_once("./bin/fix-java-app.sh")

-- Fixes for tearing
helpers.run_once("compton", "--backend glx --paint-on-overlay --glx-no-stencil --vsync opengl-swc --unredir-if-possible") 

os.execute("./bin/keyboard_layout_fix.sh")
