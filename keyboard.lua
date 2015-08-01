--[[
-- Created by IntelliJ IDEA.
-- User: LOGICIFY\corvis
-- Date: 1/10/14
-- Time: 10:38 PM
-- To change this template use File | Settings | File Templates.
--]]

globalkeys = awful.util.table.join(
    awful.key({ modkey, }, "e", function () mainmenu:toggle() end),
    awful.key({ modkey, }, "w", function () awful.menu.clients({width = 450}) end),
    awful.key({ modkey, }, "Left", awful.tag.viewprev),
    awful.key({ modkey, }, "Right", awful.tag.viewnext),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    --awful.key({ modkey, "Control" }, "q", function() awful.util.spawn_with_shell(suspender) end),


    -- Special keys integration (no modkey required)
    awful.key({ }, "XF86MonBrightnessDown", function ()
        awful.util.spawn("xbacklight -dec 10") end),
    awful.key({ }, "XF86MonBrightnessUp", function ()
        awful.util.spawn("xbacklight -inc 10") end),
	awful.key({}, "XF86Calculator", function() awful.util.spawn(calculatorCmd) end),
	awful.key({}, "XF86MyComputer", function() awful.util.spawn(fileManager) end),
	awful.key({}, "XF86Display", function() awful.util.spawn(reconfigureXrandCmd) end),	
	awful.key({}, "XF86HomePage", function() awful.util.spawn(webBrowserCmd) end),

    awful.key({ modkey, }, "j",
        function()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, }, "k",
        function()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, "j", function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, "k", function() awful.client.swap.byidx(-1) end),
    --awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    --awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus(1) end),
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus(3) end),
    awful.key({ modkey, "Control" }, "l", function() awful.screen.focus(2) end),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto),

    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),


    awful.key({ modkey, "Control" }, "]", function() awful.util.spawn("keepassx") end),
    -- Standard program
    awful.key({ modkey }, "Return", function() awful.util.spawn(terminal) end),
    awful.key({ modkey }, "f", function() awful.util.spawn(fileManager) end),
    awful.key({ modkey }, "`", function() awful.util.spawn(copyq) end),
    awful.key({ modkey }, "Print", function() awful.util.spawn("gnome-screenshot -i") end),
    awful.key({ modkey, "Mod1" }, "l", function() awful.util.spawn(locker) end),
    awful.key({ modkey, "Control" }, "Delete", function() awful.util.spawn(taskManager) end),

    awful.key({ modkey, "Control" }, "r", 
		function()
			awful.util.pread("hotplug_monitor.sh")
			awesome.restart()
		end),

    awful.key({ modkey, "Control" }, "l", function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incmwfact(-0.05) end),

    awful.key({ modkey, "Control" }, "k", function() awful.client.incwfact(0.05) end),
    awful.key({ modkey, "Control" }, "j", function() awful.client.incwfact(-0.05) end),

	awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({ modkey, }, "]", function() awful.tag.incncol(1) end),
    awful.key({ modkey, }, "[", function() awful.tag.incncol(-1) end),

    awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),

    -- Synapse launcher
    awful.key({ modkey }, "r", function() awful.util.spawn("gnome-do") end))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
-- Numpad: [0-9] = [#90, #87-#89, #83-#85, #79-#81]
local np_map = { 87, 88, 89, 83, 84, 85, 79, 80, 81 }
for i = 1, 9 do
    switchTag = function()
        local screen = mouse.screen

        if screensQty > 2 and screen ~= 3 then
            if tags[screensQty-2][i] and tags[screensQty-1][i]  then
                awful.tag.viewonly(tags[screensQty-2][i])
                awful.tag.viewonly(tags[screensQty-1][i])
            end

            else 
                if tags[screen][i]  then
                    awful.tag.viewonly(tags[screen][i])
                end

        end
    end

    switchTagOnThirdScreen = function()
        if screensQty == 3 and tags[screensQty][i]  then
            awful.tag.viewonly(tags[screensQty][i])
        end
    end

	toggleTag = function ()
        local screen = mouse.screen

        if screensQty > 2 and screen ~= 3 then
            if tags[screensQty-2][i] and tags[screensQty-1][i]  then
                awful.tag.viewtoggle(tags[screensQty-2][i])
                awful.tag.viewtoggle(tags[screensQty-1][i])
            end

            else 
                if tags[screen][i]  then
                    awful.tag.viewtoggle(tags[screen][i])
                end

        end

    end
	moveToTag = function()
		if client.focus and tags[client.focus.screen][i] then
            awful.client.movetotag(tags[client.focus.screen][i])
        end
	end

    globalkeys = awful.util.table.join(globalkeys,
		-- Switch tag
		awful.key({ modkey }, "#" .. i + 9, switchTag),
		awful.key({ modkey, "Mod1" }, "#" .. i + 9, switchTagOnThirdScreen),
		awful.key({ modkey }, "#" .. np_map[i], switchTag),

        awful.key({ modkey, "Control" }, "#" .. i + 9, toggleTag),
        awful.key({ modkey, "Control" }, "#" .. np_map[i], toggleTag),

        awful.key({ modkey, "Shift" }, "#" .. i + 9, moveToTag),
        awful.key({ modkey, "Shift" }, "#" .. np_map[i], moveToTag),

        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                --if client.focus and tags[client.focus.screen][i] then
                 --   awful.client.toggletag(tags[client.focus.screen][i])
                --end

                if client.focus and tags[1][i] then
                    awful.client.toggletag(tags[1][i])
                end
            end))
end


clientkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey, }, "F4", function(c) c:kill() end),

    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),

    awful.key({ modkey, "Control" }, "o", function(c) awful.client.movetoscreen(c, 1) end), --move to center screen
    awful.key({ modkey, "Control" }, "i", function(c) awful.client.movetoscreen(c, 3) end), --move to left screen
    awful.key({ modkey, "Control" }, "p", function(c) awful.client.movetoscreen(c, 2) end), --move to right screen

    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),

    awful.key({ modkey, }, "h", function (c) c.minimized = not c.minimized end),

    awful.key({ modkey, "Shift"   }, "m",
        function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey, }, "m",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical = not c.maximized_vertical
        end))
