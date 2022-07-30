require ('than.packer')
require('than.lsp')

local o = vim.o
local g = vim.g

o.termguicolors = true
g.material_style = 'deep ocean'
vim.cmd('colorscheme material')

g.mapleader = ' '
