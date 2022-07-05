local use = require('packer').use
require('packer').startup(function()
    use 'wbthomason/packer.nvim'
    use 'tomasr/molokai'
    use 'williamboman/nvim-lsp-installer'
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
    use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
    use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
    use 'L3MON4D3/LuaSnip' -- Snippets plugin
    use 'tpope/vim-fugitive' -- Git
    use { 'junegunn/fzf', dir = '~/.fzf', run = './install --all' }
    use { 'junegunn/fzf.vim' }
    use { 'mg979/vim-visual-multi', branch = 'master' } -- Multi cursors
    use 'preservim/nerdtree'
    use 'preservim/nerdcommenter'
    use 'hashivim/vim-terraform'
end)
