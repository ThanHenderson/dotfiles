---@type ChadrcConfig
local M = {}

M.ui = {
  theme = "gruvbox_light",

  statusline = {
    separator_style = {
      ["right"] = "█",
      ["left"] = "",
    },
  },

  tabufline = {
    lazyload = false,
  },
}

M.plugins = "custom.plugins"
M.mappings = require "custom.mappings"

return M

