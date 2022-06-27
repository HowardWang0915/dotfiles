local awful = require('awful')
local mod = require("bindings.mod")

-- Define mouse clilcking events
client.connect_signal('request::default_mousebindings', function()
   awful.mouse.append_client_mousebindings{
      awful.button{ -- Click directly
	 modifiers = {},
	 button = 1,
	 on_press = function(c) c:activate{context = 'mouse_click'} end
      },
      awful.button{
	 modifiers = {mod.super},
	 button    = 1,
	 on_press  = function(c) c:activate{context = 'mouse_click', action = 'mouse_move'} end
      },
      awful.button{
	 modifiers = {mod.super},
	 button    = 3,
	 on_press  = function(c) c:activate{context = 'mouse_click', action = 'mouse_resize'} end
      },
   }
end)

