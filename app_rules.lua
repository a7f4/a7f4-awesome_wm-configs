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
            buttons = clientbuttons,
            size_hints_honor = false
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
    
    --- {{{ CopyQ Rules
    {
        rule = { class = "Copyq"},
        properties = {
            floating = true,
            x = screen[1].workarea.width - 200,
            width = 400,
            height = 200
        },
        callback = function(c)
            awful.client.movetoscreen(c, 1)
        end
    },

    {
        rule = { class = "Skype", role = "Chats" },
        properties = {
            floating = false
        },
        callback = awful.client.setslave
    },
    -- }}}
    --{
        --rule = { class = "VirtualBox" },
        --properties = { tag = tags[1][4] }
    --},
	-- IntelJ Products: Main window should be floating and almost fullscreen (java issue workaround)
	{
		rule_any = { class = {"jetbrains-pychar", "jetbrains-webstorm", "jetbrains-phpstorm"} },
		except = { skip_taskbar = true },
        properties = { 
			tag = tags[mouse.screen][4],
			floating = true,
			switchtotag = true,
			x=5,
			y=45,
			width=screen[mouse.screen].workarea.width - 20,
			height=screen[mouse.screen].workarea.height - 35
		}
	},
    {
        rule = { class = "Thunderbird" },
        properties = { tag = tag_mail }
    },
	-- For wine applications windows which are not presented in taskbar should be always on top
	{
		rule = { class = "Wine", skip_taskbar = true },
		properties = { ontop = true }        
	}
}

return awful.rules.rules
