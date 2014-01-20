--[[
-- Created by IntelliJ IDEA.
-- User: LOGICIFY\corvis
-- Date: 1/10/14
-- Time: 10:40 PM
-- To change this template use File | Settings | File Templates.
--]]

local awful = require("awful")
local naughty = require("naughty")
awful.rules = require("awful.rules")

awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            keys = clientkeys,
            buttons = clientbuttons
        }
    },
    {
        rule = { class = "pinentry" },
        properties = { floating = true }
    },

    -- {{{ Gimp rules: we want the main window to be tiled,
    --     however all the helper windows (toolbox, docks, etc) to be floating.
    {
        rule = { class = "Gimp", role = "gimp-toolbox" },
        properties = { ontop = true }
    },
    {
        rule = { class = "Gimp", role = "gimp-toolbox-color-dialog" },
        properties = { ontop = true }
    },
    {
        rule = { class = "Gimp", role = "gimp-dock" },
        properties = { ontop = true }
    },
    -- }}}
    -- Logout window should be maximized
    {
        rule = { class = "Oblogout" },
        properties = { floating = true,
        callback = function (c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical   = not c.maximized_vertical
        end}
    },
    -- {{{ Skype Rules
    {
        rule = { class = "Skype" },
        properties = { tag = tag_skype },
        callback = awful.client.setslave

    },
    {
        rule = { class = "Skype", role = "MainWindow" },
        properties = {
            floating = false
        },
        callback = awful.client.setmaster
    },
    {
        rule = { class = "Skype", role = "Chats" },
        properties = {
            floating = false
        },
        callback = awful.client.setslave
    },
    -- }}}
    {
        rule = { class = "VirtualBox" },
        properties = { tag = tags[1][4] }
    },
	-- IntelJ Products
	{
		rule_any = { class = {"jetbrains-pychar", "jetbrains-webstorm"} },
		except = { skip_taskbar = true },
        properties = { 
			tag = tags[mouse.screen][2],
			floating = true,
			switchtotag = true,
			x=5,
			y=40,
			width=screen[mouse.screen].workarea.width - 20,
			height=screen[mouse.screen].workarea.height - 30
		}
	}
}

return awful.rules.rules
