--[[
-- Created by IntelliJ IDEA.
-- User: LOGICIFY\corvis
-- Date: 1/10/14
-- Time: 10:38 PM
-- To change this template use File | Settings | File Templates.
--]]

globalkeys = awful.util.table.join(
    awful.key({ modkey, }, "s", function () menubar.show() end),
    awful.key({ modkey, }, "Left", awful.tag.viewprev),
    awful.key({ modkey, }, "Right", awful.tag.viewnext),
    awful.key({ modkey, }, "Escape", awful.tag.history.restore),

    -- Special keys integration (no modkey required)
    awful.key({}, "XF86PowerOff", function() awful.util.spawn(logoutCmd) end),
--    awful.key({}, "XF86AudioRaiseVolume", function() awful.util.spawn("amixer set Master 5%+ unmute") end),
--    awful.key({}, "XF86AudioLowerVolume", function() awful.util.spawn("amixer set Master 5%- unmute") end),
--    awful.key({}, "XF86AudioMute", function() awful.util.spawn("amixer set Master toggle") end),
    awful.key({}, "XF86Sleep", function() awful.util.spawn("systemctl suspend") end),


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
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative(1) end),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end),
    awful.key({ modkey, }, "u", awful.client.urgent.jumpto),
    awful.key({ modkey, }, "Tab",
        function()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end),

    -- Standard program
    awful.key({ modkey }, "t", function() awful.util.spawn(terminal) end),
    awful.key({ modkey }, "f", function() awful.util.spawn(fileManager) end),
    awful.key({ modkey }, "e", function() awful.util.spawn(visualEditor) end),
    awful.key({ modkey, "Control" }, "l", function() awful.util.spawn(locker) end),
    awful.key({ modkey, "Control" }, "Delete", function() awful.util.spawn(taskManager) end),

    awful.key({ modkey, "Control" }, "r", 
		function()
			awful.util.pread("hotplug_monitor.sh")
			awesome.restart()
		end),

    awful.key({ modkey, }, "=", function() awful.tag.incmwfact(0.05) end),
    awful.key({ modkey, }, "-", function() awful.tag.incmwfact(-0.05) end),
    awful.key({ modkey, "Shift" }, "h", function() awful.tag.incnmaster(1) end),
    awful.key({ modkey, "Shift" }, "l", function() awful.tag.incnmaster(-1) end),
    awful.key({ modkey, "Control" }, "h", function() awful.tag.incncol(1) end),
    awful.key({ modkey, "Control" }, "l", function() awful.tag.incncol(-1) end),

    awful.key({ modkey, }, "space", function() awful.layout.inc(layouts, 1) end),

    -- Prompt
    awful.key({ modkey }, "r", function() mypromptbox[mouse.screen]:run() end)
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = awful.util.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9,
            function()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewonly(tags[screen][i])
                end
            end),
        awful.key({ modkey, "Control" }, "#" .. i + 9,
            function ()
                local screen = mouse.screen
                if tags[screen][i] then
                    awful.tag.viewtoggle(tags[screen][i])
                end
            end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.movetotag(tags[client.focus.screen][i])
                end
            end),
        awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
            function ()
                if client.focus and tags[client.focus.screen][i] then
                    awful.client.toggletag(tags[client.focus.screen][i])
                end
            end))
end


clientkeys = awful.util.table.join(
    awful.key({ modkey, "Control" }, "f", function(c) c.fullscreen = not c.fullscreen end),
    awful.key({ modkey, }, "F4", function(c) c:kill() end),

    awful.key({ modkey, "Control" }, "space", awful.client.floating.toggle),
    awful.key({ modkey, "Control" }, "Return", function(c) c:swap(awful.client.getmaster()) end),

    awful.key({ modkey, }, "o", awful.client.movetoscreen),
    awful.key({ modkey, }, "t", function(c) c.ontop = not c.ontop end),

    awful.key({ modkey, }, "Return",
        function(c)
            c.maximized_horizontal = not c.maximized_horizontal
            c.maximized_vertical = not c.maximized_vertical
        end))
