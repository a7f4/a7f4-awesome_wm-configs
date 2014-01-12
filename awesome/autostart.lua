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
helpers.run_once("xscreensaver", "-no-splash")

-- Setup keyboard layout
helpers.run_once("setxkbmap", "-option grp:caps_toggle \"us,ru\"")

-- Network Manager
helpers.run_once("nm-applet")

-- Power manager
helpers.run_once("xfce4-power-manager")


