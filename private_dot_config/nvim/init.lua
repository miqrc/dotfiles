-- Key mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', 'U', '<C-R>', { noremap = true, silent = true }) -- Redo
vim.api.nvim_set_keymap('n', '<Leader>f', ':FZF<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Rg<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})

-- Set options
vim.opt.relativenumber = true
vim.opt.tabstop = 4        -- Width of a TAB character
vim.opt.shiftwidth = 4     -- Size of an 'indent'
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.softtabstop = 4    -- Number of spaces tabs count for in insert mode
vim.opt.clipboard = "unnamedplus"

-- L&F
local status_ok, gruvbox = pcall(require, "gruvbox")
if status_ok then
    vim.o.background = "dark" -- or "light" for light mode
    vim.cmd([[colorscheme gruvbox]])
end

-- LSPs

local status_ok, lspconfig = pcall(require, "lspconfig")
if status_ok then

    local status_ok, cmp = pcall(require, "cmp")
    cmp.setup({
        snippet = {
            -- REQUIRED - you must specify a snippet engine
            expand = function(args)
                vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
                -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
                -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            end,
        },
        window = {
            -- completion = cmp.config.window.bordered(),
            -- documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
            ['<C-b>'] = cmp.mapping.scroll_docs(-4),
            ['<C-f>'] = cmp.mapping.scroll_docs(4),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
            { name = 'nvim_lsp' },
            { name = 'vsnip' }, -- For vsnip users.
            -- { name = 'luasnip' }, -- For luasnip users.
            -- { name = 'ultisnips' }, -- For ultisnips users.
            -- { name = 'snippy' }, -- For snippy users.
        }, {
            { name = 'buffer' },
        })
    })

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
            { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
            { name = 'buffer' },
        })
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
            { name = 'buffer' }
        }
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
            { name = 'path' }
        }, {
            { name = 'cmdline' }
        })
    })

    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- rust
    lspconfig.rust_analyzer.setup({
	    capabilities = capabilities,
        on_attach = function(client, bufnr)
            local opts = { noremap=true, silent=true }
        end
    })

    -- TypeScript and JavaScript configuration
    lspconfig.tsserver.setup({
	    capabilities = capabilities,
        on_attach = function(client, bufnr)
            local opts = { noremap=true, silent=true }
        end,
        filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
        cmd = { "typescript-language-server", "--stdio" },
        settings = {
            -- Add settings here
        }
    })

    -- Go
    lspconfig.gopls.setup({
	    capabilities = capabilities,
        on_attach = function(client, bufnr)
            local opts = { noremap=true, silent=true }
        end,
        cmd = {"gopls", "serve"},
        settings = {
            gopls = {
                analyses = {
                    unusedparams = true,
                    shadow = true,
                },
                staticcheck = true,
            },
        },
    })

    lspconfig.bashls.setup({
	    capabilities = capabilities,
        on_attach = function(client, bufnr)
            local opts = { noremap=true, silent=true }
        end,
        filetypes = { "sh", "bash" }, -- Ensure that 'sh' and 'bash' filetypes are covered
    })



end


-- Plugins
return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    -- fzf and related plugins
    use { 'junegunn/fzf', run = './install --all' }  -- We run the install script for fzf
    use 'junegunn/fzf.vim'  -- This is the fzf Vim integration

    use { "ellisonleao/gruvbox.nvim" }

end)
