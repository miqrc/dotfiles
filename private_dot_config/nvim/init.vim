let mapleader =","

" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" PLUGINS
call plug#begin('~/.vim/plugged')

"Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
"Plug 'jacoborus/tender.vim'

call plug#end()


" NETRW 
let g:netrw_banner = 0
" Default tree view
let g:netrw_liststyle = 3
" File tree on the left when opening a file with 'v'
let g:netrw_altv=1
" Preview (p) in vertical split
let g:netrw_preview = 1
let g:netrw_winsize = 25

map <Leader>m :Lexplore<CR>


" APPEARANCE

" Truecolor
if (has("termguicolors"))
    set termguicolors
endif

" Enable Molokai theme
let g:rehash256 = 1
colorscheme molokai


" BASICS
set number relativenumber
set tabstop=4       " width of a TAB char 
set shiftwidth=4    " actual indent size
set expandtab       " spaces instead of tabs
set softtabstop=4   " 4 spaces 


" REMAPS
imap jj <Esc>
" Redo
map U <C-R>
