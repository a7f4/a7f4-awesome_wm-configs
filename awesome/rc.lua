-- Standard awesome library
local gears = require("gears")
awful = require("awful")
beautiful = require("beautiful")
require("awful.autofocus")

-- Notification library
local naughty = require("naughty")
local onscreen_wigets = require("onscreen_wigets")
local helpers = require("helpers")

-- This is used later as the default terminal and editor to run.
terminal = "gnome-terminal"
fileManager = "thunar"
visualEditor = "gedit"
taskManager = "lxtask"
locker = "gnome-screensaver-command -l"
logoutCmd = "oblogout"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e nano"
themeLocation = awful.util.getdir("config") .. "/themes/logicify"
themeFile = themeLocation .. "/theme.lua"
-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
    -- Make sure we don't go into an endless error loop
        if in_error then return end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = err
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
wibox = beautiful.init(themeFile)

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.magnifier,
    awful.layout.suit.floating,
}
-- }}}

-- {{{ Wallpaper
-- Set walpaper for each screen
if beautiful.wallpaper then
    for s = 1, screen.count() do
        gears.wallpaper.maximized(beautiful.wallpaper, s, true)
    end
end
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
    -- Each screen has its own tag table.
    tags[s] = awful.tag({ 'WEB', 'WORK', 'SKYPE', 'WIN', 'TERM', 'GRAPH' }, s, layouts[1])
end
-- }}}

tag_skype = tags[1][3]
awful.layout.set(awful.layout.suit.tile.left, tag_skype)
awful.tag.setncol(2, tag_skype)
awful.tag.setmwfact (0.2, tag_skype)
awful.tag.setnmaster (1, tag_skype)

require("ui")

-- {{{ Key bindings
dofile(awful.util.getdir("config") .. "/keyboard.lua")
-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Mouse buttons
dofile(awful.util.getdir("config") .. "/mouse.lua")
-- }}}

-- {{{ Rules
dofile(awful.util.getdir("config") .. "/app_rules.lua")
-- }}}

awful.util.spawn_with_shell("wmname LG3D")

dofile(awful.util.getdir("config") .. "/autostart.lua")
