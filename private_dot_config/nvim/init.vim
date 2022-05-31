let mapleader =","

" Install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


" PLUGINS
call plug#begin('~/.vim/plugged')

Plug 'morhetz/gruvbox'

call plug#end()


" APPEARANCE

" Truecolor
if (has("termguicolors"))
    set termguicolors
endif

" Enable gruvbox with italics
let g:gruvbox_italic=1
autocmd vimenter * ++nested colorscheme gruvbox

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
