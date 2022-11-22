
" Redo
map U <C-R>

lua require('plugins')

if !exists('g:vscode')
    " Neovim with CLI
    " VSCode neovim plugin doesn't allow insert mode remaps
    imap jj <Esc>     
    
    " BASICS
    let mapleader =","
    set number relativenumber
    set tabstop=4       " width of a TAB char 
    set shiftwidth=4    " actual indent size
    set expandtab       " spaces instead of tabs
    set softtabstop=4   " 4 spaces 

    lua require('plugins-cli')
    lua require('setup-treesitter')
    lua require('lsp')

endif