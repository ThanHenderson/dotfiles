local overrides = require("custom.configs.overrides")

---@type NvPluginSpec[]
local plugins = { -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    dependencies = { -- format & linting
      {
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
          require "custom.configs.null-ls"
        end,
      },
    },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end, -- Override to setup mason-lspconfig
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
    lazy = false,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },


  {
    'NeogitOrg/neogit',
    cmd = {"Neogit"},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = function ()
      local colors = require("base46").get_theme_tb "base_30"
      vim.cmd(string.format("highlight def NeogitDiffAdd             guifg=%s", colors.green))
      vim.cmd(string.format("highlight def NeogitDiffAddHighlight    guifg=%s", colors.green))
      vim.cmd(string.format("highlight def NeogitDiffDelete          guifg=%s", colors.red))
      vim.cmd(string.format("highlight def NeogitDiffDeleteHighlight guifg=%s", colors.red))
      vim.cmd(string.format("highlight def NeogitHunkHeader          guibg=%s guifg=%s", colors.grey, colors.black))
      vim.cmd(string.format("highlight def NeogitHunkHeaderHighlight guibg=%s guifg=%s", colors.light_grey, colors.black))

      require("neogit").setup ({
        use_telescope = true,
      })
    end
  },

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- All NvChad plugins are lazy-loaded by default
  -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
  -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
  -- {
  --   "mg979/vim-visual-multi",
  --   lazy = false,
  -- }
  {
    "folke/trouble.nvim",
    cmd = { "Trouble", "TroubleToggle" },
    config = true,
  },
  {
    "fatih/vim-go",
    opts = overrides.vimgo,
    lazy = false,
  },
}

return plugins
