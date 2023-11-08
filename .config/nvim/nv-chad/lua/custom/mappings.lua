---@type MappingsTable
local M = {}

-- In order to disable a default keymap, use
M.disabled = {
  n = {
    ["<leader>n"] = "", -- Toggle numbers
  },
}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<leader>s"] = { ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", "Replace all occurrences of current word" },
    ["H"] = { "^", "Go to the beginning of the line" },
    ["L"] = { "$", "Go to the end of the line" },
    ["ZZ"] = { "<cmd> wqa <CR>", "Save file all buffers and exit" },
  },
  i = {
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },
  },
  v = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["<C-j>"] = { ":m '>+1<CR>gv=gv", "Move highlighted text down" },
    ["<C-k>"] = { ":m '<-2<CR>gv=gv", "Move highlighted text up" },
    ["<C-h>"] = { "<gv", "Indent to the left" },
    ["<C-l>"] = { ">gv", "Indent to the right" },
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

-- Half page jump keeps cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep search items centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Disable ex mode
vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "d", '"_d', { nowait = true })
vim.keymap.set("n", "<leader>d", "d", { nowait = true })

return M

