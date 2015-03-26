local lain    = require("lain")
require("ui.menu")
vicious = require("vicious")
local wibox = require("wibox")

datewidget = wibox.widget.textbox()
-- Register widget
--vicious.register(datewidget, vicious.widgets.date, "%b %d, %R", 60)
vicious.register(datewidget, vicious.widgets.date, "%R, %a %Y-%m-%d", 60)


-- {{{ Wibox
markup = lain.util.markup
blue   = "#80CCE6"
space3 = markup.font("Tamsyn 3", " ")
space2 = markup.font("Tamsyn 2", " ")
-- Menu icon
awesome_icon = wibox.widget.imagebox()
awesome_icon:set_image(beautiful.awesome_icon)
awesome_icon:buttons(awful.util.table.join( awful.button({ }, 1, function() mainmenu:toggle() end)))

-- Clock
mytextclock = awful.widget.textclock(markup("#FFFFFF", space3 .. "%H:%M" .. space2))
clock_icon = wibox.widget.imagebox()
clock_icon:set_image(beautiful.clock)
clockwidget = wibox.widget.background()
clockwidget:set_widget(mytextclock)
clockwidget:set_bgimage(beautiful.widget_bg)

-- Calendar
mytextcalendar = awful.widget.textclock(markup("#FFFFFF", space3 .. "%d %b<span font='Tamsyn 5'> </span>"))
calendar_icon = wibox.widget.imagebox()
calendar_icon:set_image(beautiful.calendar)
calendarwidget = wibox.widget.background()
calendarwidget:set_widget(mytextcalendar)
calendarwidget:set_bgimage(beautiful.widget_bg)
lain.widgets.calendar:attach(calendarwidget, { fg = "#FFFFFF", position = "bottom_right" })

-- Battery
batwidget = lain.widgets.bat({
    settings = function()
        bat_header = "<span weight=\"bold\">⚡</span> "
        bat_p      = bat_now.perc .. "% "

        if bat_now.status == "Not present" then
            bat_header = ""
            bat_p      = ""
        end

        widget:set_markup(markup(blue, bat_header) .. bat_p)
    end
})


-- CPU
cpu_widget = lain.widgets.cpu({
    settings = function()
        widget:set_markup(space3 .. "CPU " .. cpu_now.usage
                .. "%" .. markup.font("Tamsyn 5", " "))
    end
})
cpuwidget = wibox.widget.background()
cpuwidget:set_widget(cpu_widget)
cpuwidget:set_bgimage(beautiful.widget_bg)
cpu_icon = wibox.widget.imagebox()
cpu_icon:set_image(beautiful.cpu)

-- Net
netdown_icon = wibox.widget.imagebox()
netdown_icon:set_image(beautiful.net_down)
netup_icon = wibox.widget.imagebox()
netup_icon:set_image(beautiful.net_up)
netwidget = lain.widgets.net({
    settings = function()
        widget:set_markup(markup.font("Tamsyn 1", " ") .. net_now.received .. " - "
                .. net_now.sent .. space2)
    end
})
networkwidget = wibox.widget.background()
networkwidget:set_widget(netwidget)
networkwidget:set_bgimage(beautiful.widget_bg)

-- Separators
first = wibox.widget.textbox('<span font="Tamsyn 4"> </span>')
last = wibox.widget.imagebox()
last:set_image(beautiful.last)
spr = wibox.widget.imagebox()
spr:set_image(beautiful.spr)
spr_small = wibox.widget.imagebox()
spr_small:set_image(beautiful.spr_small)
spr_very_small = wibox.widget.imagebox()
spr_very_small:set_image(beautiful.spr_very_small)
spr_right = wibox.widget.imagebox()
spr_right:set_image(beautiful.spr_right)
spr_bottom_right = wibox.widget.imagebox()
spr_bottom_right:set_image(beautiful.spr_bottom_right)
spr_left = wibox.widget.imagebox()
spr_left:set_image(beautiful.spr_left)
bar = wibox.widget.imagebox()
bar:set_image(beautiful.bar)
bottom_bar = wibox.widget.imagebox()
bottom_bar:set_image(beautiful.bottom_bar)

-- Create a wibox for each screen and add it
mywibox = {}
mybottomwibox = {}
mypromptbox = {}
mylayoutbox = {}
mytaglist = {}
mytaglist.buttons = awful.util.table.join(awful.button({}, 1, awful.tag.viewonly),
    awful.button({ modkey }, 1, awful.client.movetotag),
    awful.button({}, 3, awful.tag.viewtoggle),
    awful.button({ modkey }, 3, awful.client.toggletag),
    awful.button({}, 4, function(t) awful.tag.viewnext(awful.tag.getscreen(t)) end),
    awful.button({}, 5, function(t) awful.tag.viewprev(awful.tag.getscreen(t)) end))
mytasklist = {}
mytasklist.buttons = awful.util.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        -- Without this, the following
        -- :isvisible() makes no sense
        c.minimized = false
        if not c:isvisible() then
            awful.tag.viewonly(c:tags()[1])
        end
        -- This will also un-minimize
        -- the client, if needed
        client.focus = c
        c:raise()
    end
end),
    awful.button({}, 3, function()
        if instance then
            instance:hide()
            instance = nil
        else
            instance = awful.menu.clients({ width = 350 })
        end
    end),
    awful.button({}, 4, function()
        awful.client.focus.byidx(1)
        if client.focus then client.focus:raise() end
    end),
    awful.button({}, 5, function()
        awful.client.focus.byidx(-1)
        if client.focus then client.focus:raise() end
    end))

for s = 1, screen.count() do


    -- Create a promptbox for each screen
    mypromptbox[s] = awful.widget.prompt()

    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    mylayoutbox[s] = awful.widget.layoutbox(s)
    mylayoutbox[s]:buttons(awful.util.table.join(awful.button({}, 1, function() awful.layout.inc(layouts, 1) end),
        awful.button({}, 3, function() awful.layout.inc(layouts, -1) end),
        awful.button({}, 4, function() awful.layout.inc(layouts, 1) end),
        awful.button({}, 5, function() awful.layout.inc(layouts, -1) end)))
    -- Create a taglist widget
    mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.filter.all, mytaglist.buttons)


    -- Create a tasklist widget
    mytasklist[s] = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, mytasklist.buttons)

    -- Create the wibox
    mywibox[s] = awful.wibox({ position = "top", screen = s, height = 24 })

    -- Widgets that are aligned to the left
    local left_layout = wibox.layout.fixed.horizontal()
    left_layout:add(awesome_icon)
    left_layout:add(first) -- Separator
    left_layout:add(mytaglist[s])
    left_layout:add(mylayoutbox[s])
    left_layout:add(spr_small) -- Small separator
    left_layout:add(mypromptbox[s])

    -- Widgets that are aligned to the right
    local right_layout = wibox.layout.fixed.horizontal()
    if s == 1 then right_layout:add(wibox.widget.systray()) end
    right_layout:add(batwidget)
    right_layout:add(spr_very_small)
    right_layout:add(spr_left)


    -- Now bring it all together (with the tasklist in the middle)
    local layout = wibox.layout.align.horizontal()
    layout:set_left(left_layout)
    --layout:set_middle(mytasklist[s])
    layout:set_right(right_layout)

    mywibox[s]:set_widget(layout)

    -- Create the bottom wibox
    mybottomwibox[s] = awful.wibox({ position = "bottom", screen = s, border_width = 0, height = 24 })

    -- Widgets that are aligned to the bottom left
    bottom_left_layout = wibox.layout.fixed.horizontal()
    -- bottom_left_layout:add(awesome_icon)

    -- Widgets that are aligned to the bottom right
    bottom_right_layout = wibox.layout.fixed.horizontal()
    bottom_right_layout:add(spr_bottom_right)
    bottom_right_layout:add(netdown_icon)
    bottom_right_layout:add(networkwidget)
    bottom_right_layout:add(netup_icon)
    bottom_right_layout:add(bottom_bar)
    bottom_right_layout:add(cpu_icon)
    bottom_right_layout:add(cpuwidget)
    bottom_right_layout:add(bottom_bar)
--    bottom_right_layout:add(calendar_icon)
--    bottom_right_layout:add(calendarwidget)
    bottom_right_layout:add(bottom_bar)
    bottom_right_layout:add(clock_icon)
    bottom_right_layout:add(datewidget)
    --bottom_right_layout:add(clockwidget)
    bottom_right_layout:add(last)
    -- Now bring it all together (with the tasklist in the middle)
    bottom_layout = wibox.layout.align.horizontal()
    bottom_layout:set_left(bottom_left_layout)
    bottom_layout:set_middle(mytasklist[s])
    bottom_layout:set_right(bottom_right_layout)
    mybottomwibox[s]:set_widget(bottom_layout)

    -- Set proper backgrounds, instead of beautiful.bg_normal
    -- mywibox[s]:set_bg(beautiful.topbar_path .. screen[mouse.screen].workarea.width .. ".png")
    mybottomwibox[s]:set_bg("#242424")

    -- Create a borderbox above the bottomwibox
    lain.widgets.borderbox(mybottomwibox[s], s, { position = "top", color = "#0099CC" } )
end
-- }}}

require("ui.windows")

return wibox
