
--[[
                                                  
     Licensed under GNU General Public License v2 
      * (c) 2013,      Luke Bonham                
      * (c) 2010-2012, Peter Hofmann              
      * (c) 2015, Aleksand Block
                                                  
--]]

local first_line   = require("lain.helpers").first_line
local newtimer     = require("lain.helpers").newtimer

local wibox        = require("wibox")

local math         = { ceil   = math.ceil }
local string       = { format = string.format,
                       gmatch = string.gmatch }
local tostring     = tostring

local setmetatable = setmetatable

-- Bitstamp trade 
-- lain.widgets.bitstamp
local bitstamp = {
    trade_data = ''
}

local function worker(args)
    local args     = args or {}
    local timeout  = args.timeout or 5
    local settings = args.settings or function() end

    bitstamp.widget = wibox.widget.textbox('')

    function update()
        -- Read the trade data from file 
        
        local trade_data = first_line("/dev/shm/bitstamp_trade.log")

        bitstamp_now = {}
        bitstamp_now.trade_data = trade_data

        widget = bitstamp.widget
        settings()

        -- Save current data for the next run.
        bitstamp.trade_data = trade_data
    end

    newtimer("bitstamp", timeout, update)

    return bitstamp.widget
end

return setmetatable(bitstamp, { __call = function(_, ...) return worker(...) end })
