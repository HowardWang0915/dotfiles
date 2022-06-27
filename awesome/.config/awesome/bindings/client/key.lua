local awful = require('awful')

local mod = require('bindings.mod')
local apps = require('config.apps')

client.connect_signal('request::default_keybindings', function()
			 awful.keyboard.append_client_keybindings{
			    awful.key{     -- Toggle fullscreen
			       modifiers = {mod.super, mod.shift},
			       key = 'f',
			       description = 'Toggle Fullscreen',
			       group = 'client',
			       on_press = function(c)
				  c.fullscreen = not c.fullscreen
				  c:raise()
			       end,
			    },
			    awful.key{    -- close the window
			       modifiers   = {mod.super},
			       key         = 'q',
			       description = 'Close',
			       group       = 'client',
			       on_press    = function(c) c:kill() end,
			    },
			    awful.key{    -- Toggle floating
			       modifiers   = {mod.super},
			       key         = 'f',
			       description = 'Toggle floating',
			       group       = 'client',
			       on_press    = awful.client.floating.toggle,
			    },
			    awful.key{    -- Move to master
			       modifiers   = {mod.crtl},
			       key         = 'Return',
			       description = 'Move to Master',
			       group       = 'client',
			       on_press    = function(c) c:swap(awful.client.getmaster()) end,
			    },
			    -- brightness and volume control
			    awful.key{
			       modifiers = {},
			       key = "XF86AudioRaiseVolume",
			       Description = 'Volume Up',
			       group = 'client',
			       on_press = awful.spawn("amixer set Master 3%+")
			    },
			    awful.key{
			       modifiers = {},
			       key = "XF86AudioLowerVolume",
			       Description = 'Volume Down',
			       group = 'client',
			       on_press = awful.spawn("amixer set Master 3%-")
			    },
			    awful.key{
			       modifiers = {},
			       key = "XF86AudioMute",
			       Description = 'Mute',
			       group = 'client',
			       on_press = awful.spawn("amixer set Master toggle")
			    },
			    awful.key{
			       modifiers = {},
			       key = "XF86MonBrightnessUp",
			       Description = 'Increase Brightness',
			       group = 'client',
			       on_press = awful.spawn("xbacklight -inc 10")
			    },
			    awful.key{
			       modifiers = {},
			       key = "XF86MonBrightnessDown",
			       Description = 'Decrease Brightness',
			       group = 'client',
			       on_press = awful.spawn("xbacklight -dec 10")
			    },
			    -- browser
			    awful.key{
			       modifiers = {mod.super},
			       key = "b",
			       Description = 'Open Browser',
			       group = 'app',
			       on_press = awful.spawn(apps.browser)
			    }
			 }
end)
