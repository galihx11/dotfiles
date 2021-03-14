local wibox = require('wibox')
local dpi = require("beautiful.xresources").apply_dpi
local color = require("beautiful.xresources").get_current_theme()
local awful = require('awful')
local beautiful = require('beautiful')
local gears = require('gears')
local icon = require('utils.icon')

local logout = wibox {
   visible = false,
   ontop = true,
   bg = beautiful.bg_normal .. 'AA',
   type = 'dock',
}

awful.placement.maximize(logout)

local function logout_visibility()
   if logout.visible == true then
      logout.visible = false
   else
      logout.visible = true
   end
end

logout:buttons(gears.table.join(
   awful.button({ }, 3, function ()
      logout_visibility()
   end)
))

local sugeng_ndalu = wibox.widget {
   text = 'Sugeng ndalu' .. ' ' .. os.getenv('USER'),
   font = 'Pacifico bold 50',
   widget = wibox.widget.textbox,
}

local clock = wibox.widget {
   format = '%R',
   font = 'pragmatapro 25',
   widget = wibox.widget.textclock
}

local day = wibox.widget {
   format = '%d %B, %Y',
   font = 'pragmatapro 15',
   widget = wibox.widget.textclock
}

local text_left = wibox.widget {
   nil,
   {
      sugeng_ndalu,
      {
         clock,
         day,
         spacing = dpi(5),
         layout = wibox.layout.fixed.vertical
      },
      spacing = dpi(20),
      layout = wibox.layout.fixed.vertical
   },
   nil,
   layout = wibox.layout.align.vertical
}

local power_button = wibox.widget {
   {
      text = icon.gylph.power,
      font = 'pragmatapro 30',
      widget = wibox.widget.textbox
   },
   fg = color.foreground,
   widget = wibox.container.background
}

 power_button:buttons(gears.table.join(awful.button({ }, 1,
   function()
      awful.spawn('poweroff')
   end)
))


local logout_button = wibox.widget {
   {
      text = icon.gylph.logout,
      font = 'pragmatapro 30',
      widget = wibox.widget.textbox
   },
   fg = color.foreground,
   widget = wibox.container.background
}

 logout_button:buttons(gears.table.join(awful.button({ }, 1,
   function()
      awful.spawn('pkill awesome')
   end)
))

local reboot_button = wibox.widget {
   {
      text = icon.gylph.reboot,
      font = 'pragmatapro 30',
      widget = wibox.widget.textbox
   },
   fg = color.foreground,
   widget = wibox.container.background
}

 reboot_button:buttons(gears.table.join(awful.button({ }, 1,
   function()
      awful.spawn('reboot')
   end)
))

local home_button = wibox.widget {
   {
      text = icon.gylph.home,
      font = 'pragmatapro 30',
      widget = wibox.widget.textbox
   },
   fg = color.foreground,
   widget = wibox.container.background
}

home_button:buttons(gears.table.join(
   awful.button({ }, 1, function ()
      logout_visibility()
   end)
))


local button = wibox.widget {
   nil,
   {
      power_button,
      logout_button,
      reboot_button,
      home_button,
      spacing = dpi(20),
      layout = wibox.layout.fixed.vertical
   },
   nil,
   layout = wibox.layout.align.vertical
}

local left = wibox.widget {
   nil,
   {
      text_left,
      margins = dpi(50),
      layout = wibox.container.margin
   },
   nil,
   expand = "none",
   layout = wibox.layout.align.vertical
}

local right = wibox.widget {
   nil,
   {
      button,
      margins = dpi(50),
      layout = wibox.container.margin
   },
   nil,
   expand = "none",
   layout = wibox.layout.align.vertical
}

logout:setup {
   left,
   nil,
   right,
   layout = wibox.layout.align.horizontal,
}

return logout