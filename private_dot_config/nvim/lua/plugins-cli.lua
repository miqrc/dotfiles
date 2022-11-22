local use = require('packer').use
require('packer').startup(function()

    use 'wbthomason/packer.nvim'

    -- LSP
    use 'williamboman/nvim-lsp-installer'
    use { 'neovim/nvim-lspconfig', tag = 'v0.*' }

    -- CMP
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin

    -- Tree sitter (Experimental)
    use {
        'nvim-treesitter/nvim-treesitter',
        run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
    }

end)
