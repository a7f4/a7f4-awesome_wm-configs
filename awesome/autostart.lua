--[[
-- Created by IntelliJ IDEA.
-- User: LOGICIFY\corvis
-- Date: 1/12/14
-- Time: 11:05 PM
This file should define scenario from ruining custom 3rd party applications
and services which should be started immediately after initialization of desktop environment
--]]
local helpers = require("helpers")

-- Start screen sever daemon
helpers.run_once("gnome-screensaver")

-- Setup keyboard layout
helpers.run_once("setxkbmap", "-option grp:caps_toggle \"us,ru\"")

-- Network Manager
helpers.run_once("nm-applet")

-- Volume control icon
helpers.run_once("volumeicon")

-- Power manager
helpers.run_once("xfce4-power-manager")

-- Application launcher
helpers.run_once("synapse", "-s")

-- Enable numlock
helpers.run_once("numlockx", "on")

-- Google chrome
helpers.run_once("/opt/google/chrome/google-chrome --no-startup-window")
