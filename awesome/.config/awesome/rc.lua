-- Import lua rocks
pcall(require, "luarocks.loader")

-- Import some neccessary libraries
local beautiful = require("beautiful")
local awful = require("awful")
local gears = require("gears")

-- Load the theme path into awesome
local theme_dir = gears.filesystem.get_configuration_dir() .. "theme/"
beautiful.init(theme_dir .. "theme.lua")

-- key and mouse bindings
require("bindings")
require("rules")
require("signals")
