" BASICS
let mapleader =","
set number relativenumber
set tabstop=4       " width of a TAB char 
set shiftwidth=4    " actual indent size
set expandtab       " spaces instead of tabs
set softtabstop=4   " 4 spaces 

lua require('plugins')
lua require('setup')
lua require('setup-lualine')
lua require('setup-neotree')
lua require('setup-treesitter')
lua require('lsp')
 

" APPEARANCE

" Truecolor
if (has("termguicolors"))
    set termguicolors
endif

" Enable theme
let g:tokyonight_style="night"
let g:tokyonight_italic_functions = 1
colorscheme tokyonight


" REMAPS

map <Leader>m :NeoTreeRevealToggle<CR>
map <leader>n <cmd>Telescope find_files<cr>
map <leader>k <cmd>Telescope live_grep<cr>

map <Leader>g :DiffviewOpen<CR>
imap jj <Esc>
" Redo
map U <C-R>

" CTRL+/ Comment line (NERD Commenter)
nmap <C-_>   <Plug>NERDCommenterToggle
vmap <C-_>   <Plug>NERDCommenterToggle<CR>gv



