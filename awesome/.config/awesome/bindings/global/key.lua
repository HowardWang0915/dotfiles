-- Awesome buit-in apis
local awful = require("awful")
local menubar = require("menubar")
local widgets = require("widgets")

-- User defined apis
local apps = require("config.apps") -- user defined apps
local mod = require("bindings.mod") -- mod keys definition

-- global variables
menubar.utils.terminal = apps.terminal

-- focus related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers = {mod.super},
      key = 'F1',
      description = 'Show Help',
      group = 'awesome',
      on_press = awful.hotkeys_popup.show_help,
   },
   awful.key{
      modifiers = {mod.super},
      key = 'w',
      description = 'Show Main Menu',
      group = 'awesome',
      on_press = function() widgets.mainmenu:show() end
   },
   awful.key{
      modifiers = {mod.super, mod.shift},
      key = 'r',
      description = 'Reload Awesome',
      group = 'awesome',
      on_press = awesome.restart
   },
   awful.key{
      modifiers = {mod.super},
      key = 'Return',
      description = 'Spawn Terminal',
      group = 'launcher',
      on_press = function() awful.spawn(apps.terminal) end
   },
}
-- focus related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers = {mod.super},
      key = 'j',
      description = 'Focus Next Window',
      group = 'client',
      on_press = function() awful.client.focus.byidx(1) end
   },
   awful.key{
      modifiers = {mod.super},
      key = 'k',
      description = 'Focus Previous Window',
      group = 'client',
      on_press = function() awful.client.focus.byidx(-1) end
   }
}

-- layout related keybindings
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers = {mod.super, mod.shift},
      key = 'j',
      description = 'Swap Windows Next',
      group = 'client',
      on_press = function() awful.client.swap.byidx(1) end
   },
   awful.key{
      modifiers = {mod.super, mod.shift},
      key = 'k',
      description = 'Swap windows Previous',
      group = 'client',
      on_press = function() awful.client.swap.byidx(-1) end
   },
   awful.key{
      modifiers = {mod.super},
      key = 'l',
      description = 'Increase Master Width Factor',
      group = 'client',
      on_press = function() awful.tag.incmwfact(0.05) end,
   },
   awful.key{
      modifiers = {mod.super},
      key = 'h',
      description = 'Decrease Master Width Factor',
      group = 'client',
      on_press = function() awful.tag.incmwfact(-0.05) end,
   },
   awful.key{
      modifiers = {mod.super, mod.shift},
      key = 'l',
      description = 'Increase The Number of Master Client',
      group = 'client',
      on_press = function() awful.tag.incnmaster(1, nil, true) end,
   },
   awful.key{
      modifiers = {mod.super},
      key = 'h',
      description = 'Decrease Master Width Factor',
      group = 'client',
      on_press = function() awful.tag.incnmaster(-1, nil, true) end,
   },
   awful.key{
      modifiers   = {mod.super},
      key         = 'space',
      description = 'Select Next Layout',
      group       = 'layout',
      on_press    = function() awful.layout.inc(1) end,
   },
   awful.key{
      modifiers   = {mod.super, mod.shift},
      key         = 'space',
      description = 'Select Previous Layout',
      group       = 'layout',
      on_press    = function() awful.layout.inc(-1) end,
   },
}
awful.keyboard.append_global_keybindings{
   awful.key{
      modifiers   = {mod.super},
      keygroup    = 'numrow',
      description = 'View Tag',
      group       = 'tag',
      on_press    =
      function(index)
         local screen = awful.screen.focused()
         local tag = screen.tags[index]
         if tag then
            tag:view_only(tag)
         end
      end
   },
    awful.key{
      modifiers   = {mod.super, mod.shift},
      keygroup    = 'numrow',
      description = 'Move Focused Client to Tag',
      group       = 'tag',
      on_press    =
      function(index)
	 if client.focus then
	    local tag = client.focus.screen.tags[index]
	    if tag then
	       client.focus:move_to_tag(tag)
	    end
	 end
      end
   }
}
