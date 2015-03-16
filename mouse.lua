--[[
-- Created by IntelliJ IDEA.
-- User: LOGICIFY\corvis
-- Date: 1/10/14
-- Time: 10:38 PM
-- To change this template use File | Settings | File Templates.
--]]
--local awful = require("awful")


clientbuttons = awful.util.table.join(
    awful.button({}, 1, function(c) client.focus = c; c:raise() end),
    awful.button({ modkey }, 1, awful.mouse.client.move),
    awful.button({ modkey }, 3, awful.mouse.client.resize),
    awful.button({ modkey, "Control" }, 1, function(c) c:kill() end)
)

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
    awful.button({}, 3, function() mainmenu:toggle() end),
    awful.button({}, 4, awful.tag.viewnext),
    awful.button({}, 5, awful.tag.viewprev)))
-- }}}
