-- Define all the libraries here
local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require('naughty')
local ruled = require('ruled')
local dpi   = require("beautiful.xresources").apply_dpi

-- Some predefined variables
local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility
-- ----------------------------------- Colors --------------------------------------
local colors = {}
colors.purple = '#BD93F9'
--189,147,249
colors.pink = '#FF79C6'
--255,121,198
colors.red = '#FF5555'
--255,85,85
colors.orange = '#FFB86C'
--255,184,108
colors.green = '#4DC76E'
--77,199,110
colors.yellow = '#E6D80B'
--230,216,11
colors.cyan = '#8BE9FD'
--139,233,255
colors.background = '#282A36'
--40,42,54
colors.selection = '#44475A'
--68,71,90
colors.comment = '#6272A4'
--98,114,164
colors.white = '#DDDDDD'
colors.black = '#333333'

colors.alpha = function(color, alpha)
    return color..alpha
end
-- ---------------------------------- Theme variables -----------------------------------------
local theme = {}
theme.dir = os.getenv("HOME") .. "/.config/awesome/themes/dracula"
theme.wallpaper = theme.dir .. "/wall.png"
theme.fg_normal = '#000000'
theme.bg_normal = 'transparent'
theme.border_normal = colors.selection
theme.border_focus = colors.cyan
theme.useless_gap   = dpi(4)
theme.border_width  = dpi(7)

theme.hotkeys_bg = colors.selection
theme.hotkeys_fg = colors.white
theme.hotkeys_modifiers_fg = colors.purple
theme.hotkeys_border_color = colors.green
theme.hotkeys_group_margin = 10

-- Icon set
theme.widget_power = theme.dir .. "/icons/power.svg"
theme.widget_bluetooth_off = theme.dir .. "/icons/bluetooth-off.svg"
theme.widget_bluetooth_on = theme.dir .. "/icons/bluetooth-on.svg"
theme.widget_no_noti_filled = theme.dir .. "/icons/no-notifs-fill.svg"
theme.widget_noti_filled = theme.dir .. "/icons/notifs-fill.svg"
theme.widget_wifi = theme.dir .. "/icons/wifi-strong.svg"
theme.widget_battery = theme.dir .. "/icons/battery-discharge.svg"
theme.widget_vol_high = theme.dir .. "/icons/volume-high.svg"
theme.widget_ship_wheel = theme.dir .. "/icons/ship-wheel.svg"
theme.icon_awesome = theme.dir .. "icons/awesome.svg"
theme.icon_dracula = theme.dir .. "icons/dracula.svg"
client.shape_clip = 4

local icon_height = dpi(140)
local icon_width = dpi(50)

-- clickablae container helper function
local clickable_container = function(widget)
	local container = wibox.widget {
		widget,
		widget = wibox.container.background
	}

	-- Old and new widget
	local old_cursor, old_wibox

	-- Mouse hovers on the widget
	container:connect_signal(
		'mouse::enter',
		function()
			container.bg = beautiful.groups_bg
			-- Hm, no idea how to get the wibox from this signal's arguments...
			local w = mouse.current_wibox
			if w then
				old_cursor, old_wibox = w.cursor, w
				w.cursor = 'hand1'
			end
		end
	)

	-- Mouse leaves the widget
	container:connect_signal(
		'mouse::leave',
		function()
			container.bg = beautiful.leave_event
			if old_wibox then
				old_wibox.cursor = old_cursor
				old_wibox = nil
			end
		end
	)

	-- Mouse pressed the widget
	container:connect_signal(
		'button::press',
		function()
			container.bg = beautiful.press_event
		end
	)

	-- Mouse releases the widget
	container:connect_signal(
		'button::release',
		function()
			container.bg = beautiful.release_event
		end
	)

	return container
end
------------------------ Create Notifications ----------------

naughty.config.padding = dpi(8)
naughty.config.spacing = dpi(8)
naughty.config.icon_formats = { 'svg', 'png', 'jpg', 'gif' }

ruled.notification.connect_signal(
	'request::rules',
	function()
		-- Critical notifs
		ruled.notification.append_rule {
			rule = { urgency = 'critical' },
			properties = {
				implicit_timeout = 0
			}
		}
		-- Normal notifs
		ruled.notification.append_rule {
			rule = { urgency = 'normal' },
			properties = {
				implicit_timeout = 5
			}
		}

		-- Low notifs
		ruled.notification.append_rule {
			rule = { urgency = 'low' },
			properties = {
				implicit_timeout = 2
			}
		}
	end
)

naughty.connect_signal(
	'request::display_error',
	function(message, startup)
		naughty.notification {
			urgency = 'critical',
			title   = 'You done gone messed up a-a-ron'..(startup and ' during startup!' or ''),
			message = message,
			app_name = 'System Notification',
			icon = theme.icon_awesome
		}
	end
)

local main_color = {
    ['low'] = colors.green,
    ['normal'] = colors.selection,
    ['critical'] = '#cc6666',
}

local edge_color = {
    ['low'] = colors.purple,
    ['normal'] = colors.purple,
    ['critical'] = colors.red,
}

naughty.connect_signal(
	'request::display',
	function(n)
		local custom_notification_icon = wibox.widget {
            font = "Nerd Font 18",
            align = "center",
            valign = "center",
            widget = wibox.widget.textbox
        }

		local main_color = main_color[n.urgency]
		local edge_color = edge_color[n.urgency]
		local icon = theme.icon_awesome

        n.font = "Nerd Font 15"
		local actions = wibox.widget {
			notification = n,
			widget_template = {
				{
					{
						{
							id = 'text_role',
							font = beautiful.notification_font,
							widget = wibox.widget.textbox
						},
						left = dpi(6),
						right = dpi(6),
						widget = wibox.container.margin
					},
					widget = wibox.container.place
				},
				bg = main_color,
				forced_height = dpi(25),
				forced_width = dpi(70),
				widget = wibox.container.background
			},
			style = {
                underline_normal = false,
                underline_selected = true
			},
			widget = naughty.list.actions
		}

		local notif_icon = wibox.widget {
	        {
	            {
	                {
                        image = theme.icon_dracula,
                        widget = wibox.widget.imagebox,
                    },
					margins = dpi(5),
                    widget = wibox.container.margin
				},
				shape = gears.shape.rect,
				bg = edge_color,
				widget = wibox.container.background
            },
            forced_width = 40,
            forced_height = 40,
            widget = clickable_container
        }
		naughty.layout.box {
            notification = n,
            type = "notification",
            -- For antialiasing: The real shape is set in widget_template
            shape = function(cr, width, height)
                gears.shape.rounded_rect(cr, width, height, dpi(4))
            end,
            position = "top_right",
            widget_template = {
	            {
	                {
	                    notif_icon,
                        {
	                        {
	                            {
                                    align = "center",
                                    visible = true,
                                    font = "Nerd Font 20",
                                    markup = "<b>"..n.title.."</b>",
                                    widget = wibox.widget.textbox,
                                    -- widget = naughty.widget.title,
	                            },
                                {
                                    align = "center",
                                    --wrap = "char",
                                    widget = naughty.widget.message,
                                    font = "Nerd Font 15"
                                },
                                {
                                    wibox.widget {
                                        forced_height = dpi(10),
                                        layout = wibox.layout.fixed.vertical
                                    },
                                    {
                                        actions,
                                        shape = function(cr, width, height)
                                            gears.shape.rounded_rect(cr, width, height, dpi(4))
                                        end,
                                        widget = wibox.container.background,
                                    },
                                    visible = n.actions and #n.actions > 0,
                                    layout  = wibox.layout.fixed.vertical
                                },
                                layout  = wibox.layout.align.vertical,
                            },
                            margins = dpi(4),
                            widget  = wibox.container.margin,
                        },
                        layout  = wibox.layout.fixed.horizontal,
                    },
                    strategy = "max",
                    width    = dpi(350),
                    height   = dpi(180),
                    widget   = wibox.container.constraint,
                },
              -- Anti-aliasing container
                shape = function(cr, width, height)
                    gears.shape.rounded_rect(cr, width, height, dpi(4))
                end,
                bg = main_color,
                fg = colors.white,
                border_width = dpi(1),
                border_color = colors.background,
                widget = wibox.container.background
            }
        }
	end
)
-- --------------------- Bar function starts here --------------------------------
-- End session icon
local end_sesssion_icon =
    wibox.widget { { { { {
                    image = theme.widget_power,
                    widget = wibox.widget.imagebox
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.comment,
            widget = wibox.container.background
        },
        forced_width = icon_width,
        forced_height = icon_height,
        widget = clickable_container
    },
    top = dpi(5),
    right = dpi(7),
    widget = wibox.container.margin
}
-- TODO Finish click item
-- local exit_screen_grabber
end_sesssion_icon:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.with_shell("sh ~/.config/rofi/powermenu/powermenu.sh")
            end
        )
    )
)

-- -------------------------System clock
local time = '%H:%M:%S'
local date = '%d.%b.%Y'

local clock_icon  = wibox.widget {
    format = time,
    refresh = 1,
    widget = wibox.widget.textclock,
    font = "Nerd Font 12",
    align = "center"
}
theme.clock = wibox.widget {
    {
        {
            {
                {
                    clock_icon,
                    layout = wibox.layout.fixed.horizontal,
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(25),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.purple,
            fg = '#FFFFFF',
            widget = wibox.container.background
      },
      forced_width = dpi(130),
      forced_height = icon_height,
      widget = clickable_container
    },
    top = dpi(5),
    right = dpi(12),
    widget = wibox.container.margin
}
theme.clock.widget:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                if clock_icon.format == time then
                    clock_icon:set_format(date)
                elseif clock_icon.format == date then
                    clock_icon:set_format(time)
                end
            end
        ),
        awful.button(
            {},
            3,
            nil,
            function()
                awesome.emit_signal("cal:toggle")
            end
        )
    )
)
-- ----------------------------------- Bluetooth widget ---------------
local bluetooth = wibox.widget {
    {
        {
            {
                {
                    image = theme.widget_bluetooth_off,
                    widget = wibox.widget.imagebox,
                },
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.green,
            widget = wibox.container.background
        },
        forced_width = icon_width,
        forced_height = icon_height,
        widget = clickable_container
    },
    top = dpi(5),
    right = dpi(7),
    widget = wibox.container.margin
}
-- TODO bluetooth button actions

bluetooth:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awesome.emit_signal("bluetoothCenter:toggle")
                awesome.emit_signal("bluetooth::devices:refreshPanel")
            end
        )
    )
)
-- ----------------------------------- Notification widget ---------------
local noti_icon = wibox.widget {
    layout = wibox.layout.align.vertical,
    expand = 'none',
    nil,
    {
        id = 'icon',
        image = theme.widget_no_noti_filled,
        resize = true,
        widget = wibox.widget.imagebox
    },
    nil
}

local notifications = wibox.widget {
    {
        {
             {
                {
                    noti_icon,
                    layout = wibox.layout.fixed.horizontal,
                },
                top = dpi(5),
                bottom = dpi(5),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.pink,
            widget = wibox.container.background
        },
        forced_width = icon_width,
        forced_height = icon_height,
        widget = clickable_container
    },
    top = dpi(5),
    right = dpi(7),
    widget = wibox.container.margin
}
awesome.connect_signal(
    "notificationsEmpty:true",
    function()
        noti_icon.icon:set_image(theme.widget_no_noti_filled)
    end
)
awesome.connect_signal(
    "notificationsEmpty:false",
    function()
        noti_icon.icon:set_image(theme.widget_noti_filled)
    end
)
-- TODO finish notification button
-- ------------------- Network button -------------------------
local network = wibox.widget {
     {
        {
            {
                {
                    image = theme.widget_wifi,
                    widget = wibox.widget.imagebox
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.red,
            widget = wibox.container.background
        },
        forced_width = icon_width,
        forced_height = icon_height,
        widget = clickable_container
    },
    top = dpi(5),
    right = dpi(7),
    widget = wibox.container.margin
}

network:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awesome.emit_signal("network:toggle")
                awful.spawn.with_shell("sh ~/.config/rofi/rofi-wifi-menu/rofi-wifi-menu.sh")
            end
        )
    )
)
-- Set up network dashboard

--[[ local format_item = function(widget)
    return wibox.widget {
		{
			{
				layout = wibox.layout.align.vertical,
				expand = 'none',
				nil,
				widget,
				nil
			},
			margins = dpi(5),
			widget = wibox.container.margin
		},
		shape = function(cr, width, height)
			gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
		end,
        bg = 'transparent',
		widget = wibox.container.background
	}
end

local title = wibox.widget {
    {
        {
            spacing = dpi(0),
            layout = wibox.layout.flex.vertical,
            format_item( {
    			layout = wibox.layout.fixed.horizontal,
    			spacing = dpi(16),
                require('widget.dracula-icon'),
                require('widget.network-center.title-text'),
    		}),
        },
        margins = dpi(5),
        widget = wibox.container.margin
    },
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
    end,
    bg = colors.alpha(colors.selection, 'F2'),
    forced_width = width,
    forced_height = 70,
    ontop = true,
    border_width = dpi(2),
    border_color = colors.background,
    widget = wibox.container.background,
    layout,
}

local status = wibox.widget {
  {
      {
      spacing = dpi(0),
    	layout = wibox.layout.flex.vertical,
    	format_item(
    		{
    			layout = wibox.layout.fixed.horizontal,
    			spacing = dpi(16),
            require('widget.network-center.status-icon'),
            require('widget.network-center.status'),
    		}
    	),
    },
    margins = dpi(5),
    widget = wibox.container.margin
  },
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, beautiful.groups_radius)
  end,
  bg = colors.alpha(colors.selection, 'F2'),
  forced_width = width,
  forced_height = 70,
  ontop = true,
  border_width = dpi(2),
  border_color = colors.background,
  widget = wibox.container.background,
  layout,
}

networkCenter = wibox(
  {
    x = screen_geometry.width-width-dpi(8),
    y = screen_geometry.y+dpi(35),
    visible = false,
    ontop = true,
    screen = screen.primary,
    type = 'splash',
    height = screen_geometry.height-dpi(35),
    width = width,
    bg = 'transparent',
    fg = '#FEFEFE',
  }
)

_G.nc_status = false

awesome.connect_signal(
  "network:toggle",
  function()
    if networkCenter.visible == false then
      network_status = true
      networkCenter.visible = true
    elseif networkCenter.visible == true then
      network_status = false
      networkCenter.visible = false
    end
  end
)

networkCenter:setup {
  spacing = dpi(15),
  title,
  status,
  layout = wibox.layout.fixed.vertical,
} ]]
-- ---------------------------- Battery ---------------------------------
local battery = wibox.widget {
    {
        {
            {
                {
                    image = theme.widget_battery;
                    widget = wibox.widget.imagebox
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.orange,
            widget = wibox.container.background
        },
        forced_width = icon_width,
        forced_height = icon_height,
        widget = clickable_container
    },
    top = dpi(5),
    right = dpi(7),
    widget = wibox.container.margin
}

-- TODO Finish this
--[[ battery:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                _G.exit_screen_show()
            end
        )
    )
) ]]

-- ------------------ Volume widget --------------------------
local volume = wibox.widget {
    {
        {
            {
                {
                    image = theme.widget_vol_high,
                    widget = wibox.widget.imagebox
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.yellow,
            widget = wibox.container.background
        },
        forced_width = icon_width,
        forced_height = icon_height,
        widget = clickable_container
    },
    top = dpi(5),
    right = dpi(7),
    widget = wibox.container.margin
}
volume:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awesome.emit_signal("volumeCenter:toggle")
            end
        )
    )
)
theme.volume = lain.widget.alsabar({}) -- modular control
-- ---------------------------- Menu ---------------------------
local menu = wibox.widget {
    {
        {
            {
                {
                    image = theme.widget_ship_wheel,
                    widget = wibox.widget.imagebox
                },
                top = dpi(3),
                bottom = dpi(3),
                left = dpi(17),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.comment,
            widget = wibox.container.background
      },
      forced_width = icon_width,
      forced_height = icon_height,
      widget = clickable_container
    },
        top = dpi(5),
    left = dpi(7),
    widget = wibox.container.margin
}
-- Define button for the menu
menu:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.with_shell('rofi -no-lazy-grab -show drun -theme dracula/centered.rasi')
            end
        )
        --[[ awful.button(
            {},
            3,
            nil,
            function()
                awful.spawn.with_shell('./.config/xmenu/xmenu.sh')
            end
        ) ]]
    )
)
-- The task list widget
local task_content = wibox.widget {
    text = "Arch Dracula",
    widget = wibox.widget.textbox,
    font = "Nerd Font 12"
}

local lenMax = 42

awful.widget.watch (
    [[bash -c "xdotool getwindowclassname $(xdotool getactivewindow)"]],
    1,
    function(_, stdout)
        local name = stdout
        if name == "" then
            name = "Arch Dracula"
        end
        if string.len(name) > lenMax then
            name = string.sub(name, 1, 42).."..."
        end
        task_content:set_text(name)
        collectgarbage('collect')
    end
)

local focused = wibox.widget {
    {
        {
            {
                {
                    task_content,
                    layout = wibox.layout.fixed.horizontal,
                },
                top = dpi(4),
                bottom = dpi(4),
                left = dpi(12),
                right = dpi(12),
                widget = wibox.container.margin
            },
            shape = gears.shape.rounded_bar,
            bg = colors.purple,
            fg = 'white',
            widget = wibox.container.background
        },
        widget = clickable_container
    },
    top = dpi(5),
    left = dpi(7),
    widget = wibox.container.margin
}

focused:buttons(
    gears.table.join(
        awful.button(
            {},
            1,
            nil,
            function()
                awful.spawn.with_shell('rofi -no-lazy-grab -show window -theme dracula/centered.rasi')
            end
        )
    )
)

focused:connect_signal(
    "mouse::enter",
    function()
        lenMax = 300
    end
)

focused:connect_signal(
    "mouse::leave",
    function()
        lenMax = 42
    end
)

function theme.at_screen_connect(s)
    -- If wallpaper is a function, call it with the screen
    local wallpaper = theme.wallpaper
    if type(wallpaper) == "function" then
        wallpaper = wallpaper(s)
    end
    gears.wallpaper.maximized(wallpaper, s, true)

    -- Tags
    awful.tag(awful.util.tagnames, s, awful.layout.layouts[1])
    s.mypromptbox = awful.widget.prompt()
    -- Create an imagebox widget which will contains an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(my_table.join(
                           awful.button({}, 1, function () awful.layout.inc( 1) end),
                           awful.button({}, 2, function () awful.layout.set( awful.layout.layouts[1] ) end),
                           awful.button({}, 3, function () awful.layout.inc(-1) end),
                           awful.button({}, 4, function () awful.layout.inc( 1) end),
                           awful.button({}, 5, function () awful.layout.inc(-1) end)))
    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, awful.util.taglist_buttons, { spacing = 7 })

	local taglist = wibox.widget {
        {
            {
                {
                    {
						s.mytaglist,
						layout = wibox.layout.fixed.horizontal,
					},
					top = dpi(6),
					bottom = dpi(6),
					left = dpi(16),
					right = dpi(0),
					widget = wibox.container.margin
				},
				shape = gears.shape.rounded_bar,
				bg = 'transparent',
				fg = 'transparent',
				shape_border_width = dpi(3),
				shape_border_color = colors.purple,
				widget = wibox.container.background
			},
			forced_width = icon_height,
			forced_height = icon_height,
			widget = clickable_container
		},
		top = dpi(5),
		widget = wibox.container.margin
	}

	beautiful.taglist_shape = gears.shape.circle
	beautiful.taglist_shape_border_width = dpi(1)

	beautiful.taglist_fg_focus = colors.purple
	beautiful.taglist_bg_focus = colors.purple
	beautiful.taglist_shape_border_color_focus = colors.purple

	beautiful.taglist_bg_empty = 'transparent'
	beautiful.taglist_shape_border_color_empty = colors.purple

	-- beautiful.taglist_bg_volatile = 'transparent'
	-- beautiful.taglist_shape_border_color_volatile = vol_color

	beautiful.taglist_bg_occupied = 'transparent'
	beautiful.taglist_shape_border_color = colors.cyan

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, awful.util.tasklist_buttons)

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = dpi(30), bg = theme.bg_normal, fg = theme.fg_normal })
    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = 'none',
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(5),
            s.mylayoutbox,
            menu,
            focused,
            s.mypromptbox
        },
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(5),
            taglist
        },
        {
            layout = wibox.layout.fixed.horizontal,
            spacing = dpi(5),
            volume,
            battery,
            network,
            notifications,
            bluetooth,
            theme.clock.widget,
            end_sesssion_icon
        },
    }
end

return theme
