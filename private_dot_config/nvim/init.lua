-- Key mappings
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('i', 'jj', '<Esc>', {noremap = true})
vim.api.nvim_set_keymap('n', 'U', '<C-R>', { noremap = true, silent = true }) -- Redo
vim.api.nvim_set_keymap('n', '<Leader>f', ':FZF<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', ':Rg<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<Leader>b', ':Buffers<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<Leader>n', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>gg', '<cmd>Neogit<CR>', { noremap = true, silent = true })

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

-- NvimTree
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- setup 
local status_ok, nvim_tree = pcall(require, "nvim-tree")
if status_ok then
    nvim_tree.setup({
        on_attach = function(client, bufnr)
            local api = require "nvim-tree.api"

            local function opts(desc)
                return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
            end

            -- default mappings
            api.config.mappings.default_on_attach(bufnr)

            -- custom mappings
            vim.keymap.set('n', '<C-t>', api.tree.change_root_to_parent,        opts('Up'))
            vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('Help'))
        end,
        sort_by = "case_sensitive",
        view = {
            width = 30,
        },
        renderer = {
            group_empty = true,
        },
        filters = {
            dotfiles = true,
        },
        actions = {
            open_file = {
                quit_on_open = true,
            },
        },
    })
end


local status_ok, lualine = pcall(require, "lualine")
if status_ok then
    lualine.setup({
        options = {
            icons_enabled = true,
            theme = 'auto',
            component_separators = { left = '', right = ''},
            section_separators = { left = '', right = ''},
            disabled_filetypes = {
                statusline = {},
                winbar = {},
            },
            ignore_focus = {},
            always_divide_middle = true,
            globalstatus = false,
            refresh = {
                statusline = 1000,
                tabline = 1000,
                winbar = 1000,
            }
        },
        sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {'filename'},
            lualine_x = {'encoding', 'fileformat', 'filetype'},
            lualine_y = {'progress'},
            lualine_z = {'location'}
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {'filename'},
            lualine_x = {'location'},
            lualine_y = {},
            lualine_z = {}
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {}
    })
end


local status_ok, nvim_treesitter_configs = pcall(require, "nvim-treesitter.configs")
if status_ok then
    nvim_treesitter_configs.setup({
        -- A list of parser names, or "all" (the five listed parsers should always be installed)
        ensure_installed = { "rust", "typescript", "bash", "lua", "go" },
        sync_install = true,
        auto_install = true,

        highlight = {
            enable = true,

            --  Function to disable highlight for large files (slow)
            disable = function(lang, buf)
                local max_filesize = 100 * 1024 -- 100 KB
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
        },
    })
end


local status_ok, neogit = pcall(require, "neogit")
if status_ok then
    neogit.setup({
      -- Add your configuration here, or leave it empty to use the default settings
      -- For example:
      integrations = {
        -- If you have 'nvim-cmp' installed, you can enable this setting
        diffview = true  
      },
    })
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

    use 'github/copilot.vim'

    -- fzf and related plugins
    use { 'junegunn/fzf', run = './install --all' }  -- We run the install script for fzf
    use 'junegunn/fzf.vim'  -- This is the fzf Vim integration

    use { "ellisonleao/gruvbox.nvim" }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional
        },
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'nvim-tree/nvim-web-devicons', opt = true }
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'TimUntersberger/neogit',
        requires = 'nvim-lua/plenary.nvim',  -- Neogit requires plenary.nvim to function
    }

end)
