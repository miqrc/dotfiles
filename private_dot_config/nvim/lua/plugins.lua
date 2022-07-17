local use = require('packer').use
require('packer').startup(function()

    -- Vimscript
    --
    use 'mg979/vim-visual-multi'
    use 'hashivim/vim-terraform'

    -- LUA
    use 'wbthomason/packer.nvim'
    use 'folke/tokyonight.nvim'
    use { 'numToStr/Comment.nvim', tag = 'v0.*' }
    use { 'akinsho/bufferline.nvim', tag = "v2.*", requires = 'kyazdani42/nvim-web-devicons' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = 'nvim-lua/plenary.nvim' }
    use { "nvim-neo-tree/neo-tree.nvim", branch = "v2.x",
        requires = { "nvim-lua/plenary.nvim", "kyazdani42/nvim-web-devicons", "MunifTanjim/nui.nvim", } }
    use { 'nvim-lualine/lualine.nvim', requires = { 'kyazdani42/nvim-web-devicons', opt = true } }
    use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
    use 'ggandor/lightspeed.nvim'

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
