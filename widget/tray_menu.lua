local awful     = require('awful')
local wibox     = require('wibox') 
local gears     = require('gears')
local beautiful = require('beautiful')

local _M = {
  wibox = wibox {
    width = 200,
    height = 40,
    ontop = true,
    visible = false,
    bg = beautiful.titlebar_bg_focus,
    widget = wibox.widget.systray(),
  },
}

_M.toggle_menu = function(args)
  assert(args.screen ~= nil)
  local screen = args.screen

  local geom = screen.geometry
  _M.wibox:geometry {
    x = geom.x + (geom.width - _M.wibox.width),
    y = geom.y + beautiful.panel_size,
  }
  _M.wibox.visible = not _M.wibox.visible
end

_M.panel_widget = function(args)
  assert(args.screen ~= nil)

  return wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    buttons = gears.table.join(
      awful.button({}, 1, nil, function()
        _M.toggle_menu(args)
      end)
    ),
    {
      widget = wibox.widget.imagebox,
      image = beautiful.titlebar_minimize_button_normal,
    }
  }
end

return _M