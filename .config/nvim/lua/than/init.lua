require ('than.packer')

local o = vim.o
local g = vim.g

o.termguicolors = true
vim.o.background = 'dark'
vim.cmd('colorscheme rose-pine')
g.mapleader = ' '

-- Keymaps
local keymap = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }
keymap("i", "jj", "<Esc>", opts)
