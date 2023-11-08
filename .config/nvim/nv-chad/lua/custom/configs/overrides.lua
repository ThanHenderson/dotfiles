local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "javascript",
    "c",
    "cpp",
    "html",
    "markdown",
    "markdown_inline",
    "toml",
    "json",
    "yaml",
    "make",
    "bash",
    "python",
  },
  indent = {
    enable = true,
    -- disable = { "python" },
  },
}

M.mason = {
  ensure_installed = {
    -- lsp
    "lua-language-server",
    "bash-language-server",
    "clangd",
    "rust-analyzer",
    "python-lsp-server",
    "jdtls",

    -- format
    "beautysh",
    "black",
    "stylua",
    "prettier",
    "clang-format",
    "rustfmt",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
    -- to display ignored files and directories
    ignore = false,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },
}

return M
