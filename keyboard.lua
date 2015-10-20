--[[
-- Created by IntelliJ IDEA.
-- User: LOGICIFY\corvis
-- Date: 1/10/14
-- Time: 10:38 PM
-- To change this template use File | Settings | File Templates.
--]]

key_e = "#26"
key_w = "#25"
key_r = "#27"
key_f = "#41"
key_h = "#43"
key_m = "#58"
key_n = "#57"
key_k = "#45"
key_j = "#44"
key_l = "#46"
key_bracketRight = "#35"
key_grave = "#49"
key_o = "#32"
key_i = "#31"
key_p = "#33"
key_u = "#30"
key_tab = "#23"
key_t = "#28"
key_down = "#116"
key_left = "#113"
key_right = "#114"
key_up = "#111"
key_shift = "#50"

globalkeys = awful.util.table.join(
    awful.key({ modkey, }, key_e, function () mainmenu:toggle() end),
    awful.key({ modkey, }, key_w, function () awful.menu.clients({width = 450}) end),
    awful.key({ modkey, }, "Left", awful.tag.viewprev),
    awful.key({ modkey, }, "Right", awful.tag.viewnext),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    --awful.key({ modkey, "Control" }, "q", function() awful.util.spawn_with_shell(suspender) end),


    -- Special keys integration (no modkey required)
    awful.key({}, "XF86MonBrightnessDown", function () awful.util.spawn("xbacklight -dec 10") end),
    awful.key({}, "XF86MonBrightnessUp", function () awful.util.spawn("xbacklight -inc 10") end),
	awful.key({}, "XF86Calculator", function() awful.util.spawn(calculatorCmd) end),
	awful.key({}, "XF86MyComputer", function() awful.util.spawn(fileManager) end),
	awful.key({}, "XF86Display", function() awful.util.spawn(reconfigureXrandCmd) end),	
	awful.key({}, "XF86HomePage", function() awful.util.spawn(webBrowserCmd) end),

    awful.key({ modkey, }, key_j,
        function()
            awful.client.focus.byidx(1)
            if client.focus then client.focus:raise() end
        end),
    awful.key({ modkey, }, key_k,
        function()
            awful.client.focus.byidx(-1)
            if client.focus then client.focus:raise() end
        end),

    -- Layout manipulation
    awful.key({ modkey, "Shift" }, key_j, function() awful.client.swap.byidx(1) end),
    awful.key({ modkey, "Shift" }, key_k, function() awful.client.swap.byidx(-1) end),
    --awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    --awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey, "Control" }, key_k, function() awful.screen.focus(1) end),
    awful.key({ modkey, "Control" }, key_j, function() awful.screen.focus(3) end),
    awful.key({ modkey, "Control" }, key_l, function() awful.screen.focus(2) end),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto),

    awful.key({ modkey, }, key_tab,
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),


    awful.key({ modkey, "Control" }, key_bracketRight, function() awful.util.spawn("keepassx") end),
    -- Standard program
    awful.key({ modkey }, "Return", function() awful.util.spawn(terminal) end),
    awful.key({ modkey }, key_f, function() awful.util.spawn(fileManager) end),
    awful.key({ modkey }, key_grave, function() awful.util.spawn(copyq) end),
    awful.key({ modkey }, key_n, function() awful.util.spawn(quickNote) end),
    awful.key({ modkey, "Shift" }, key_n, function() awful.util.spawn(structuredNotes) end),
    awful.key({ modkey }, "Print", function() awful.util.spawn("gnome-screenshot -i") end),
    awful.key({ modkey, "Mod1" }, key_l, function() awful.util.spawn(locker) end),
    awful.key({ modkey, "Control" }, "Delete", function() awful.util.spawn(taskManager) end),

    awful.key({ modkey, "Control" }, key_r,
		function()
            screensQty = screen.count()
			awful.util.pread("hotplug_monitor.sh")
			awesome.restart()
		end),

    awful.key({ modkey, "Control" ,"Shift"}, key_l, function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, "Control" , "Shift"}, key_h, function() awful.tag.incmwfact(-0.05) end),

    awful.key({ modkey, "Control" ,"Shift"}, key_k, function() awful.client.incwfact(0.05) end),
    awful.key({ modkey, "Control", "Shift" }, key_j, function() awful.client.incwfact(-0.05) end),

	awful.key({ modkey, "Shift" }, key_h, function() awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Shift" }, key_l, function() awful.tag.incnmaster(-1) end),
    awful.key({ modkey, }, "]", function() awful.tag.incncol(1) end),
    awful.key({ modkey, }, "[", function() awful.tag.incncol(-1) end),

    awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),

    -- Synapse launcher
    awful.key({ modkey }, key_r, function() awful.util.spawn("synapse") end))

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
    awful.key({ modkey, "Control" }, key_f, function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey, }, "F4", function(c) c:kill() end),

    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),

    awful.key({ modkey, "Control" }, key_o, function(c) awful.client.movetoscreen(c, 1) end), --move to center screen
    awful.key({ modkey, "Control" }, key_i, function(c) awful.client.movetoscreen(c, 3) end), --move to left screen
    awful.key({ modkey, "Control" }, key_p, function(c) awful.client.movetoscreen(c, 2) end), --move to right screen

    awful.key({ modkey, }, key_t, function(c) c.ontop = not c.ontop end),

    awful.key({ modkey, }, key_h, function (c) c.minimized = not c.minimized end),

    awful.key({ modkey, "Shift"   }, key_m,
        function (c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
            c.minimized = true
        end),
    awful.key({ modkey, }, key_m,
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical = not c.maximized_vertical
        end))
