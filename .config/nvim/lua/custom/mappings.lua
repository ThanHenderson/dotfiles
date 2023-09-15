---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
}

M.mini_map = {
  n = {
    ["<leader>mf"] = {
      function()
        require('mini.map').toggle_focus()
      end,
      "Toogle focus on mini map"
    },
    ["<leader>mr"] = {
      function()
        require('mini.map').refresh()
      end,
      "Refresh mini map"
    },
    ["<leader>mt"] = {
      function()
        require('mini.map').toggle()
      end,
      "Toggle mini map"
    },
  }
}
return M
