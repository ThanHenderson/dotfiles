vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
  -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'nvim-lua/popup.nvim'
    use 'nvim-lua/plenary.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use 'nvim-telescope/telescope-file-browser.nvim'
    
    -- LSP, language server support
    use 'neovim/nvim-lspconfig'
    use 'williamboman/nvim-lsp-installer'
    use 'fatih/vim-go'
    
    --  Completion framework
    use 'hrsh7th/nvim-cmp'
    
    --  LSP completion source for nvim-cmp
    use 'hrsh7th/cmp-nvim-lsp'
    
    --  Snippet completion source for nvim-cmp
    use 'hrsh7th/cmp-vsnip'
    
    --  Other usefull completion sources
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-buffer'
    
    --  Snippet engine
    use 'hrsh7th/vim-vsnip'
    
    --  To enable more of the features of rust-analyzer, such as inlay hints and more!
    use 'simrat39/rust-tools.nvim'
    
    --  Fugative: git integration.
    use 'tpope/vim-fugitive'

    -- Tree Sitter: Parser tool that builds AST and provides better syntax highlighting.
    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    --  Markdown support in browser
    use({
        "iamcco/markdown-preview.nvim",
        run = function() vim.fn["mkdp#util#install"]() end,
    })

    --  Debugging
    use 'puremourning/vimspector'

    --  Colour Scheme
    use 'embark-theme/vim'
    use 'rose-pine/neovim'
    use 'whatyouhide/vim-gotham'
    use 'marko-cerovac/material.nvim'
    use 'bluz71/vim-moonfly-colors'
end)
